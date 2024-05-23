import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/chat_screen.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key, required this.avatar, required this.name, required this.uId});

  final File avatar;
  final String name;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return ChatScreen(avatar: avatar, name: name, uId: uId);
  })),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: FileImage(avatar),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
