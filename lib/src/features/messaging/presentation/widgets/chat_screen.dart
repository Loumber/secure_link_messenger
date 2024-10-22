import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/bloc/chat_provider.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final File avatar;
  final String name;
  final String uId;

  const ChatScreen(
      {super.key, required this.avatar, required this.name, required this.uId});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late User user;
  late ChatProvider chatProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = MyLocator.userRepository;
    user = authRepository.getCurrentUser()!;

    chatProvider = ChatProvider(user, widget.uId);

    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(_scrollController.hasClients);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => chatProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: FileImage(widget.avatar),
              ),
              SizedBox(width: 10.w),
              Text(widget.name),
            ],
          ),
        ),
        body: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            if (!chatProvider.keysInitialized) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (chatProvider.messages.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: chatProvider.messages.length,
                            itemBuilder: (context, index) {
                              final message = chatProvider.messages[index];
                              if (message['message'] != null) {
                                return ChatBubble(
                                  text: message['message'],
                                  time: message['timestamp'] ?? '',
                                  isMe: message['sender'] == user.uid,
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _controller,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.w, horizontal: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            placeholder: 'Сообщение',
                            placeholderStyle: TextStyle(
                              color: getColorFromHex("#6C6C6D"),
                            ),
                            style: TextStyle(
                              color: getColorFromHex("#6C6C6D"),
                            ),
                            onTap: () {
                              _scrollToBottom();
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CupertinoButton(
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.red[900],
                              ),
                              onPressed: () {
                                if (_controller.text.isNotEmpty) {
                                  chatProvider.sendMessage(_controller.text);
                                  _controller.clear();
                                  _scrollToBottom();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: _controller,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.w, horizontal: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          placeholder: 'Сообщение',
                          placeholderStyle: TextStyle(
                            color: getColorFromHex("#6C6C6D"),
                          ),
                          style: TextStyle(
                            color: getColorFromHex("#6C6C6D"),
                          ),
                          onTap: () {
                            _scrollToBottom();
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CupertinoButton(
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                chatProvider.sendMessage(_controller.text);
                                _controller.clear();
                                _scrollToBottom();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
