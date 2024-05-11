import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/app/di.dart';

class SearchedUser extends StatefulWidget {
  const SearchedUser(
      {super.key, required this.name, required this.avatar, required this.uId});

  final File avatar;
  final String name;
  final String uId;

  @override
  State<SearchedUser> createState() => _SearchedUserState();
}

class _SearchedUserState extends State<SearchedUser> {
  bool _isFriendAdded = false;

  @override
  void initState() {
    super.initState();
    _loadFriendStatus();
  }

  void _loadFriendStatus() async {
    if (mounted) {
      bool isFriend = await MyLocator.contactsRepository.isFriend(widget.uId);
      if (mounted) {
        setState(() {
          _isFriendAdded = isFriend;
        });
      }
    }
  }

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
              child: Image.file(widget.avatar))),
        ),
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 200.w,
        ),
        GestureDetector(
          onTap: () async {
            _loadFriendStatus();
            MyLocator.contactsRepository.addFriend(widget.uId);
          },
          child: _isFriendAdded
              ? Icon(
                  Icons.check_rounded,
                  color: Colors.red[900],
                )
              : Icon(
                  Icons.person_add_alt_1_rounded,
                  color: Colors.red[900],
                ),
        )
      ],
    );
  }
}
