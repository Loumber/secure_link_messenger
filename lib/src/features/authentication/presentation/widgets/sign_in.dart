import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordVisible = true;
  bool isEmail = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(height: 150.h, child: Image.asset('assets/images/logo.png')),
          SizedBox(
            height: 50.h,
          ),
          CupertinoTextField(
            onChanged: (value) {
              email = value;
            },
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'почта',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child: Icon(
                Icons.alternate_email_outlined,
                size: 20.sp,
                color: getColorFromHex("#6C6C6D"),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          CupertinoTextField(
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'пароль',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            onChanged: (value) {
              password = value;
            },
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child: Icon(
                Icons.lock_outline,
                size: 20.sp,
                color: getColorFromHex("#6C6C6D"),
              ),
            ),
            suffix: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
              child: IconButton(
                  onPressed: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                  icon: isPasswordVisible
                      ? Icon(
                          Icons.visibility_off_outlined,
                          size: 20.sp,
                          color: getColorFromHex("#6C6C6D"),
                        )
                      : Icon(
                          Icons.visibility_outlined,
                          size: 20.sp,
                          color: getColorFromHex("#6C6C6D"),
                        )),
            ),
            obscureText: isPasswordVisible,
          ),
          SizedBox(
            height: 25.h,
          ),
          CupertinoButton(
              borderRadius: BorderRadius.circular((36)),
              color: Colors.red[700],
              child: Text(
                'Войти',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              onPressed: () {
                if (isUnlockButton()) {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                      SignInLoadingDataEvent(
                          email: email!, password: password!));
                } else {
                  showCupertinoDialog(
                      context: context,
                      builder: (BuildContext builder) {
                        return CupertinoAlertDialog(
                          title: const Text('Неправильные данные'),
                          content: email == null || password == null
                              ? const Text('Заполните все поля')
                              : const Text('Введена не существующая почта'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Ок'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                }
              })
        ],
      ),
    );
  }

  bool isUnlockButton() {
    return password != null && email != null && EmailValidator.validate(email!);
  }

  Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
