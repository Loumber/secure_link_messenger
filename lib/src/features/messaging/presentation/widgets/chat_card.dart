import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/chat_screen.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String uid;
  final File avatar;
  final String lastMessage;
  final String dateTime;

  const ChatCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.dateTime,
    required this.avatar,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ChatScreen(avatar: avatar, name: name, uId: uid);
      })),
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.sp,
              child: ClipOval(
                child: SizedBox(
                  height: 60.h,
                  width: 60.w,
                  child: Image.file(avatar),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              dateTime,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
