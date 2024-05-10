import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';

class SearchedUser extends StatelessWidget {
  const SearchedUser({super.key, required this.name, required this.avatar, required this.uId});

  final File avatar;
  final String name;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35.sp,
          child: Image.asset('assets/images/avatar.jpg'),
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 200.w,
        ),
        GestureDetector(
          onTap: () {
            
          },
          child: Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.red[900],
          ),
        )
      ],
    );
  }
}
