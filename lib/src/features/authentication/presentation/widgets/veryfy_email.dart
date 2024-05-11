import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String? code;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: 'На почту ',
              style: TextStyle(
                color: getColorFromHex("#6C6C6D"),
                fontSize: 16.sp,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: widget.email,
                    style: TextStyle(
                      color: getColorFromHex("#6C6C6D"),
                      decoration: TextDecoration.underline,
                      fontSize: 16.sp,
                    )),
                TextSpan(
                  text: ' был отпрвлен код',
                  style: TextStyle(
                    color: getColorFromHex("#6C6C6D"),
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.w,
          ),
          SizedBox(
            height: 15.w,
          ),
          CupertinoButton(
              borderRadius: BorderRadius.circular((36)),
              color: Colors.red[700],
              child: Text(
                'Отправить повторно',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              onPressed: () {}),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(CancelSignUpEvent());
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.signUpRoot, (route) => false);
            },
            child: Text(
              'Отменить',
              style: TextStyle(
                color: getColorFromHex("#6C6C6D"),
                fontSize: 16.sp,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
