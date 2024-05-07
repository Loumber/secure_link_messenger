import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/veryfy_email.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      switch (state) {
        case AuthenticationInitial _:
          MyLoggr('AuthenticationInitial');
          return const CupertinoActivityIndicator();
        case SignUpInitial _:
          MyLoggr('SignUpInitial');
          return const CupertinoActivityIndicator();
        case SignInInitial _:
          MyLoggr('SignInInitial');
          return const Placeholder();
        case SignUpLoading _:
          MyLoggr('SignUpLoading');
          return const CupertinoActivityIndicator();
        case SignInLoading _:
          MyLoggr('SignInLoading');
          return const Placeholder();
        case SignUpEmailVerify state:
          MyLoggr('SignUpEmailVerify');
          return Padding(
            padding: EdgeInsets.fromLTRB(20.w, 90.h, 20.w, 0),
            child: VerifyEmail(email: state.email),
          );
        case IsAuthentication _:
          MyLoggr('IsAuthentication');
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.homeRoot, (route) => false);
          return const CupertinoActivityIndicator();
        case SignUpError _:
          MyLoggr('SignUpError');
          return const Placeholder();
        case SignInError():
          return const Placeholder();
      }
    })));
  }

  void MyLoggr(String str) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(str);
  }
}
