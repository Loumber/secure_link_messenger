import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        Navigator.pushNamed(context, AppRoutes.signInRoot);
        BlocProvider.of<AuthenticationBloc>(context).add(GoSignInEvent());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
            Center(child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            switch (state) {
              case SignUpInitial _:
                return Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 100.h, 30.w, 0),
                  child: const Column(children: [SignUp()]),
                );
              case SignUpLoading _:
                return const CupertinoActivityIndicator();
              case SignUpEmailVerify _:
                return CupertinoAlertDialog(
                  title: const Text('Данные успешно отправлены'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Ок'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              case IsAuthentication _:
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.homeRoot, (route) => false);
                return const CupertinoActivityIndicator();
              case SignUpError _:
                return throw UnimplementedError();
              case AuthenticationInitial _:
                return const Placeholder();
              case SignInInitial():
                return const CupertinoActivityIndicator();
              case SignInLoading():
                return const Placeholder();
              case SignInError():
                return const Placeholder();
            }
          },
        )),
      ),
    );
  }
}
