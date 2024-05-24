import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';

class SignOutBotton extends StatelessWidget {
  const SignOutBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: CupertinoButton(
          borderRadius: BorderRadius.circular((0)),
          color: Colors.grey[200],
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(SignOutEvent());
            var logger = Logger(
              printer: PrettyPrinter(),
            );
            logger.d(AppRoutes.signInRoot);
            logger.d(Navigator.pushNamed(context, AppRoutes.signInRoot));
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.signInRoot, (route) => false);
          },
          child: Text(
            'Выйти',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
          )),
    );
  }
}
