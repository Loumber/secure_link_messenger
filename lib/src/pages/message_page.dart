import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/message/message_entity.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/my_chats.dart';
import 'package:logger/logger.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<ChatEntity> myChats = [];

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    List<ChatEntity> chats = await getUserChats();
    setState(() {
      myChats = chats;
    });
  }

  Future<List<ChatEntity>> getUserChats() async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      logger.d(userSnapshot.data());
      final userData = userSnapshot.data();
      if (userData == null || !userData.containsKey('chats')) {
        return [];
      }

      final List<dynamic> chatIds = userData['chats'];
      logger.d(chatIds);
      List<ChatEntity> chats = [];

      for (String chatId in chatIds) {
        final messagesSnapshot = await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .get();

        List<MessageEntity> messages = messagesSnapshot.docs.map((doc) {
          final msgData = doc.data();
          DateTime now = DateTime.now();
          DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
              int.parse(msgData['timestamp']));
          return MessageEntity(
            message: msgData['message'],
            dateTime: now.difference(timestamp).inDays == 0
                ? DateFormat('HH:mm').format(timestamp)
                : DateFormat('HH:mm dd.MM.yyyy').format(timestamp),
            sender: msgData['sender'],
            recipient: msgData['recipient'],
          );
        }).toList();

        if (messages.isEmpty) {
          continue; // Пропускаем чат, если нет сообщений
        }

        final latestMessage = messages.last;
        final sender = latestMessage.sender;
        final recipient = latestMessage.recipient;

        String otherUserId;
        if (sender == currentUser.uid) {
          otherUserId = recipient;
        } else {
          otherUserId = sender;
        }

        final otherUserSnapshot = await FirebaseFirestore.instance
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

      return chats;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyChats(myChats: myChats),
    );
  }
}
