import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final User user;
  late String contactId;
  List<Map<String, dynamic>> _messages = [];

  ChatProvider(this.user, this.contactId) {
    getMessages();
  }

  List<Map<String, dynamic>> get messages => _messages;

  Future<void> getMessages() async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(getChatId())
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _messages = snapshot.docs.map((doc) => doc.data()).toList();
      _messages = _messages.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> sendMessage(String message) async {
    final messageData = {
      'message': message,
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

  Future<void> deleteMessage(String messageId) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(getChatId())
        .collection('messages')
        .doc(messageId)
        .delete();
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
