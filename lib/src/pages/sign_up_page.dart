import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/authentication/presentatiom/widgets/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.w, 100.h, 30.w, 0),
          child: const Column(
            children: [
              SignUp()
            ]),
            )
      ),
    );
  }
}