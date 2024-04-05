import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_link_messenger/src/pages/home_page.dart';
import 'package:secure_link_messenger/src/pages/sing_in_page.dart';
import 'package:secure_link_messenger/src/pages/verify_email_page.dart';
import 'package:logger/logger.dart';


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
          if (!snapshot.data!.emailVerified) {
            logger.d('верификация');
            return const VerifyEmailPage();
          }else{
            logger.d('дом');
          return const HomePage();}
        } else {
          logger.d('авторизация');
          return const SignInPage();
        }
      },
    );
  }
}