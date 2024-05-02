import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/veryfy_email.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            switch(state){
              case AuthenticationInitial _:
                return const CupertinoActivityIndicator();
              case SignUpInitial _:
                return const CupertinoActivityIndicator();
              case SignInInitial _:
                return const Placeholder();
              case SignUpLoading _:
                return const CupertinoActivityIndicator();
              case SignInLoading _:
                return const Placeholder();
              case SignUpEmailVerify _:
                return Padding(
                  padding:  EdgeInsets.fromLTRB(20.w, 90.h, 20.w, 0),
                  child: const VerifyEmail(),
                );
              case IsAuthentication _:
                return const CupertinoActivityIndicator();
              case SignUpError _:
                return const Placeholder();
            }
          }
        ))
    );
  }
} 