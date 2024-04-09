import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/presentatiom/widgets/sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.w, 250.h, 30.w, 0),
          child: Column(
            children: [
              const SignIn(),
              SizedBox(
                height: 300.h,
              ),
              CupertinoButton(
                borderRadius: BorderRadius.circular((36)),
                color: Colors.red[700],
                child: Text('Зарегистрироваться',
                    style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.signUpRoot); //
              })
              ],
          )),
      )
      );
  }

  
}