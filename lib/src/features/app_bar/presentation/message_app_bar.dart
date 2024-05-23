import 'package:flutter/material.dart';

class MessageAppBar extends StatefulWidget {
  const MessageAppBar({super.key});

  @override
  State<MessageAppBar> createState() => _MessageAppBarState();
}

class _MessageAppBarState extends State<MessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Чаты',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        
      ],
    );
  }
}
