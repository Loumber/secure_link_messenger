import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/message/message_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getUserChats();
}

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ChatRepositoryImpl(this._firebaseAuth, this._firebaseFirestore);

  @override
  Stream<List<ChatEntity>> getUserChats() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return Stream.value([]);
    }

    final userDocStream = _firebaseFirestore
        .collection('users')
        .doc(currentUser.uid)
        .snapshots();

    return userDocStream.asyncMap((userSnapshot) async {
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
          return MessageEntity(
            message: msgData['message'],
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

        final otherUserSnapshot = await _firebaseFirestore
            .collection('users')
            .doc(otherUserId)
            .get();
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

      chats.sort((a, b) => b.messages.first.dateTime.compareTo(a.messages.first.dateTime));

      return chats;
    });
  }
}
