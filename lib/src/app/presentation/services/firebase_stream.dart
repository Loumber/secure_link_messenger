import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/app/presentation/pages/home_page.dart';
import 'package:secure_link_messenger/src/pages/sing_in_page.dart';
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
          } else if (snapshot.hasData && snapshot.data!.emailVerified) {
            // snapshot.data!.delete();
            logger.d('дом');
            BlocProvider.of<AuthenticationBloc>(context)
                .add(IsAuthenticationEvent());
            return const HomePage();
          } else {
            BlocProvider.of<AuthenticationBloc>(context).add(GoSignInEvent());
            //return const SignInPage();
            return const HomePage();
          }
        });
  }
}
