import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: CupertinoButton(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.sp)),
          color: Colors.red[700],
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(DeleteAccountEvent());
            var logger = Logger(
              printer: PrettyPrinter(),
            );
            logger.d(AppRoutes.signInRoot);
            logger.d(Navigator.pushNamed(context, AppRoutes.signInRoot));
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.signInRoot, (route) => false);
          },
          child: Text(
            'Удалить аккаунт',
            style: TextStyle(
              fontSize: 18.sp,
            ),
          )),
    );
  }
}
