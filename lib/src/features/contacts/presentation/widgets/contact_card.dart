import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/pages/messaging_page.dart';

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
        return MessagingPage(name: name, avatar: avatar, uId: uId);
      })),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.sp,
              child: ClipOval(
                  child: SizedBox(
                      height: 90.h, width: 90.w, child: Image.file(avatar))),
            ),
            SizedBox(
              width: 5.w,
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
