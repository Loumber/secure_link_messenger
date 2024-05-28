import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypton/crypton.dart';

class ChatProvider with ChangeNotifier {
  final User user;
  late String contactId;
  List<Map<String, dynamic>> _messages = [];
  late RSAPrivateKey _myPrivateKey;
  late RSAPublicKey _contactPublicKey;
  late RSAPublicKey _myPublicKey;
  bool _keysInitialized = false;

  ChatProvider(this.user, this.contactId) {
    initializeKeys().then((_) {
      _keysInitialized = true;
      getMessages();
    });
  }

  List<Map<String, dynamic>> get messages => _messages;
  bool get keysInitialized => _keysInitialized;

  Future<void> initializeKeys() async {
    final currentUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final contactUserDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(contactId)
        .get();

    if (currentUserDoc.exists && contactUserDoc.exists) {
      final privateKeyPem = currentUserDoc['privateKey'];
      final myPublicKeyPem = currentUserDoc['publicKey'];
      final contactPublicKeyPem = contactUserDoc['publicKey'];

      _myPrivateKey = RSAPrivateKey.fromPEM(privateKeyPem);
      _myPublicKey = RSAPublicKey.fromPEM(myPublicKeyPem);
      _contactPublicKey = RSAPublicKey.fromPEM(contactPublicKeyPem);
    } else {
      throw Exception("Failed to fetch user keys");
    }
  }

  Future<void> getMessages() async {
    if (!_keysInitialized) return;

    FirebaseFirestore.instance
        .collection('chats')
        .doc(getChatId())
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages = snapshot.docs.map((doc) {
        var data = doc.data();
        if (data['sender'] == user.uid) {
          // Если отправитель текущий пользователь, расшифровываем его копию
          data['message'] = _decryptMessage(data['messageForSender']);
        } else {
          // Если отправитель не текущий пользователь, расшифровываем копию для получателя
          data['message'] = _decryptMessage(data['messageForRecipient']);
        }
        return data;
      }).toList();
      _messages = _messages.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> sendMessage(String message) async {
    if (!_keysInitialized) return;

    final encryptedMessageForRecipient = _contactPublicKey.encrypt(message);
    final encryptedMessageForSender = _myPublicKey.encrypt(message);
    final messageData = {
      'messageForRecipient': encryptedMessageForRecipient,
      'messageForSender': encryptedMessageForSender,
      'sender': user.uid,
      'recipient': contactId,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(getChatId())
        .collection('messages')
        .add(messageData);
    if (!await chatExistsInUserChats(user.uid, getChatId())) {
      await addChatToUserChats(user.uid, getChatId());
    }
    if (!await chatExistsInUserChats(contactId, getChatId())) {
      await addChatToUserChats(contactId, getChatId());
    }
  }

  String _decryptMessage(String encryptedMessage) {
    try {
      return _myPrivateKey.decrypt(encryptedMessage);
    } catch (e) {
      return "Unable to decrypt message";
    }
  }

  String getChatId() {
    return user.uid.hashCode <= contactId.hashCode
        ? '${user.uid}_$contactId'
        : '${contactId}_${user.uid}';
  }

  Future<bool> chatExistsInUserChats(String userId, String chatId) async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final List<dynamic> chats = userData.get('chats');
    return chats.contains(chatId);
  }

  Future<void> addChatToUserChats(String userId, String chatId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'chats': FieldValue.arrayUnion([chatId])
    });
  }
}
