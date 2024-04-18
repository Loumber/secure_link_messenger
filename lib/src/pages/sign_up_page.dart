import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/sign_up_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SignUpBloc,SignUpState>(
          builder: (context,state){
            switch (state){
              case SignUpInitial _:
                return Padding(
                padding: EdgeInsets.fromLTRB(30.w, 100.h, 30.w, 0),
                  child: const Column(
                    children: [
                      SignUp()
                    ]),
                );
              case SignUpLoading _:
                return const CupertinoActivityIndicator();
              case SignUpEmailVerify _:
                Navigator.pushNamed(context, AppRoutes.verifyEmailRoot);
                return CupertinoAlertDialog(
                  title: const Text('Данные успешно отправлены'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Ок'),
                      onPressed: () {Navigator.pop(context);},
                    )
                  ],
                );
              case IsSignUp _:
                return throw UnimplementedError();
              // TODO: Handle this case.
              case SignUpError _:
                return throw UnimplementedError();
            }
          },
        )
      ),
    );
  }
}