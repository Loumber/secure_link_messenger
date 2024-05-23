import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/app/di.dart';

class SignOutBotton extends StatelessWidget {
  const SignOutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        borderRadius: BorderRadius.circular((36)),
        color: Colors.red[700],
        onPressed: () {
          MyLocator.userRepository.signOut();
        },
        child: Text(
          'Выйти',
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ));
  }
}
