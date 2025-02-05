import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/message/message_entity.dart';
import 'package:crypton/crypton.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getUserChats();
}

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final Logger logger = Logger(printer: PrettyPrinter());

  RSAPrivateKey? _myPrivateKey;
  bool _keysInitialized = false;

  ChatRepositoryImpl(this._firebaseAuth, this._firebaseFirestore) {
    _initializeKeys();
  }

  Future<void> _initializeKeys() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) return;

    final currentUserDoc =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();
    if (currentUserDoc.exists) {
      logger.d(currentUserDoc['encryptPrivateKey']);
      final ivData = currentUserDoc['iv'];
      final privateKeyPem = decryptString(
          currentUserDoc['encryptPrivateKey'],
          currentUserDoc['email'],
          IV(Uint8List.fromList(base64Url.decode(ivData))));
      _myPrivateKey = RSAPrivateKey.fromPEM(privateKeyPem);
      _keysInitialized = true;
    }
  }

  Future<void> ensureKeysInitialized() async {
    if (!_keysInitialized) {
      await _initializeKeys();
    }
  }

  String decryptString(String encryptedKey, String keyString, IV iv) {
    final key = Key.fromUtf8(keyString.padRight(32, '\0').substring(0, 32));
    final encrypter = Encrypter(AES(key));
    final encrypted = Encrypted.fromBase64(encryptedKey);
    logger.d(encrypted);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  List<ChatEntity> searchMessages(String userName, List<ChatEntity> messages) {
    List<ChatEntity> result = [];
    for (var element in messages) {
      var elementLower = element.name.toLowerCase();
      if (elementLower.contains(userName.toLowerCase())) {
        result.add(element);
      }
    }
    return result;
  }

  @override
  Stream<List<ChatEntity>> getUserChats() async* {
    await ensureKeysInitialized();

    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      yield [];
      return;
    }

    final userDocStream =
        _firebaseFirestore.collection('users').doc(currentUser.uid).snapshots();

    yield* userDocStream.asyncMap((userSnapshot) async {
      final userData = userSnapshot.data();
      if (userData == null || !userData.containsKey('chats')) {
        return [];
      }

      final List<dynamic> chatIds = userData['chats'];
      List<ChatEntity> chats = [];

      for (String chatId in chatIds) {
        final messagesSnapshot = await _firebaseFirestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .get();

        List<MessageEntity> messages = messagesSnapshot.docs.map((doc) {
          final msgData = doc.data();
          DateTime now = DateTime.now();
          DateTime messageTime = DateTime.fromMillisecondsSinceEpoch(
              int.parse(msgData['timestamp']));
          String message;
          if (msgData['sender'] == currentUser.uid) {
            message = _decryptMessage(msgData['messageForSender']);
          } else if (_keysInitialized &&
              msgData['recipient'] == currentUser.uid) {
            message = _decryptMessage(msgData['messageForRecipient']);
          } else {
            message = msgData['messageForRecipient'];
          }

          return MessageEntity(
            message: message,
            dateTime: now.difference(messageTime).inDays == 0
                ? DateFormat('HH:mm').format(messageTime)
                : DateFormat('HH:mm dd.MM.yyyy').format(messageTime),
            sender: msgData['sender'],
            recipient: msgData['recipient'],
          );
        }).toList();
        if (messages.isEmpty) {
          continue;
        }

        final latestMessage = messages.first;
        final sender = latestMessage.sender;
        final recipient = latestMessage.recipient;

        String otherUserId;
        if (sender == currentUser.uid) {
          otherUserId = recipient;
        } else {
          otherUserId = sender;
        }

        final otherUserSnapshot =
            await _firebaseFirestore.collection('users').doc(otherUserId).get();
        final otherUserData = otherUserSnapshot.data();

        if (otherUserData == null) {
          continue;
        }

        final String otherUserName = otherUserData['name'];
        final String avatarUrl = otherUserData['imageUrl'];

        final directory = await getApplicationDocumentsDirectory();
        final avatarPath = '${directory.path}/$otherUserId-avatar.jpg';
        final avatarFile = File(avatarPath);

        if (!avatarFile.existsSync()) {
          final response = await http.get(Uri.parse(avatarUrl));
          avatarFile.writeAsBytesSync(response.bodyBytes);
        }

        chats.add(ChatEntity(
          uid: otherUserId,
          name: otherUserName,
          avatar: avatarFile,
          messages: messages,
        ));
      }

      chats.sort((a, b) =>
          b.messages.first.dateTime.compareTo(a.messages.first.dateTime));

      return chats;
    });
  }

  String _decryptMessage(String encryptedMessage) {
    if (_myPrivateKey == null) {
      throw StateError("Private key has not been initialized.");
    }
    return _myPrivateKey!.decrypt(encryptedMessage);
  }
}
