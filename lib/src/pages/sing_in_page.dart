import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              switch (state) {
                case AuthenticationInitial _:
                  var logger = Logger(
                    printer: PrettyPrinter(),
                  );
                  logger.d('AuthenticationInitial');
                  return const Placeholder();
                case SignUpInitial _:
                  return const CupertinoActivityIndicator();
                case SignInInitial _:
                  return Padding(
                      padding: EdgeInsets.fromLTRB(30.w, 80.h, 30.w, 0),
                      child: Column(
                        children: [
                          const SignIn(),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(GoSignUpEvent());
                              Navigator.pushNamed(
                                  context, AppRoutes.signUpRoot);
                            },
                            child: Text(
                              'Зарегистрироваться',
                              style: TextStyle(
                                color: getColorFromHex("#6C6C6D"),
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ));
                case SignUpLoading _:
                  return const Placeholder();
                case SignUpEmailVerify _:
                  return const Placeholder();
                case IsAuthentication():
                  //Navigator.pushNamedAndRemoveUntil(
                  //    context, AppRoutes.homeRoot, (route) => false);
                  return const CupertinoActivityIndicator();
                case SignUpError():
                  return const Placeholder();
                case SignInLoading():
                  return const CupertinoActivityIndicator();
              }
            },
          ),
        ));
  }

  Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
