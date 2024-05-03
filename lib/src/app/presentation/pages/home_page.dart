import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/presentation/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Чаты',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          switch (state) {
            case AuthenticationInitial():
              return const Placeholder();
            case SignUpInitial():
              return const Placeholder();
            case SignInInitial():
              return const Placeholder();
            case SignUpLoading():
              return const CupertinoActivityIndicator();
            case SignInLoading():
              return const CupertinoActivityIndicator();
            case SignUpEmailVerify():
              return const CupertinoActivityIndicator();
            case IsAuthentication():
              return const CupertinoActivityIndicator();
            case SignUpError():
              return const Placeholder();
          }
        }),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
