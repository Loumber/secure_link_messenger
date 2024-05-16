import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/messaging_text_field.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage(
      {super.key, required this.name, required this.avatar, required this.uId});

  final String name;
  final File avatar;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.sp,
                child: ClipOval(
                    child: SizedBox(
                        height: 90.h, width: 90.w, child: Image.file(avatar))),
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
      ),
      body: const MessagingTextField(),
    );
  }
}
