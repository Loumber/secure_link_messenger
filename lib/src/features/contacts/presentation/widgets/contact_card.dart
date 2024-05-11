import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key, required this.avatar, required this.name, required this.uId});

  final File avatar;
  final String name;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.sp,
          child: ClipOval(
            child: SizedBox(
              height: 90.h,
              width: 90.w,
              child: Image.file(avatar))),
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
    );
  }
}
