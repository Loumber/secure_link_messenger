import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:secure_link_messenger/src/app/presentation/services/firebase_stream.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/pages/home_page.dart';
import 'package:secure_link_messenger/src/pages/sign_up_page.dart';
import 'package:secure_link_messenger/src/pages/sing_in_page.dart';
import 'package:secure_link_messenger/src/pages/verify_email_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
          )
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 804),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: AppRoutes.initRoot,
            routes: <String, WidgetBuilder>{
              AppRoutes.initRoot: (context) => const FirebaseStream(),
              AppRoutes.homeRoot: (context) => const HomePage(),
              AppRoutes.signInRoot: (context) => const SignInPage(),
              AppRoutes.signUpRoot: (context) => const SignUpPage(),
              AppRoutes.verifyEmailRoot: (context) => const VerifyEmailPage()
            },
          ),
        ));
  }
}
