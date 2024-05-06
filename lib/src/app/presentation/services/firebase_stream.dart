import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/pages/home_page.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/pages/verify_email_page.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          var logger = Logger(
            printer: PrettyPrinter(),
          );
          if (snapshot.hasError) {
            return const Scaffold(
                body: Center(child: Text('Что-то пошло не так!')));
          } else if (snapshot.hasData) {
            snapshot.data!.delete();
            if (!snapshot.data!.emailVerified) {
              //snapshot.data!.delete();
              logger.d('Верификация');
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(SignUpLoadedDataEvent());
              return const VerifyEmailPage();
            } else {
              logger.d('дом');
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(IsAuthenticationEvent());
              return const HomePage();
            }
          } else {
            logger.d('Вход');
            //BlocProvider.of<AuthenticationBloc>(context).add(GoSignInEvent());
            //return const SignInPage();
            BlocProvider.of<AuthenticationBloc>(context)
                .add(IsAuthenticationEvent());
            return const HomePage();
          }
        });
  }
}
