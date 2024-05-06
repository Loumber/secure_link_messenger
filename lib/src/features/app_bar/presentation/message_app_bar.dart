import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageAppBar extends StatefulWidget {
  const MessageAppBar({super.key});

  @override
  State<MessageAppBar> createState() => _MessageAppBarState();
}

class _MessageAppBarState extends State<MessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.settings_ethernet_rounded),
          ),
          const Text(
            'Чаты',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            child: const Icon(Icons.create_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
