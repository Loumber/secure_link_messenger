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
          radius: 35.sp,
          child: Image.file(avatar),
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
