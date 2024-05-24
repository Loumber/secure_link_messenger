import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/bloc/bloc/chat_bloc.dart';

import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/my_chats.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(LoadChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is ChatLoaded) {
            return MyChats(myChats: state.chats);
          } else if (state is ChatError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          } else {
            return const Center(child: Text('Чаты не найдены'));
          }
        },
      ),
    );
  }
}
