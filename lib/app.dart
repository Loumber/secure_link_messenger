import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/bloc/friends_bloc.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/messaging/data/chat_repository_impl.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/bloc/bloc/chat_bloc.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/use_case/get_user_chats.dart';
import 'package:secure_link_messenger/src/pages/home_page.dart';

import 'package:secure_link_messenger/src/pages/sign_up_page.dart';
import 'package:secure_link_messenger/src/pages/sing_in_page.dart';
import 'package:secure_link_messenger/src/pages/verify_email_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/messaging/domain/bloc/bloc/search_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userRepository = MyLocator.userRepository;
  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    final isAuthorized = userRepository.isAuthorized;
    logger.d(isAuthorized);
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<ContactsBloc>(
            create: (context) => ContactsBloc(),
          ),
          BlocProvider<FriendsBloc>(create: (context) => FriendsBloc()),
          BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(GetUserChats(ChatRepositoryImpl(
                    FirebaseAuth.instance,
                    FirebaseFirestore.instance,
                  )))),
          BlocProvider(
            create: (context) => ChatBloc(
              GetUserChats(ChatRepositoryImpl(
                FirebaseAuth.instance,
                FirebaseFirestore.instance,
              )),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 804),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute:
                isAuthorized ? AppRoutes.homeRoot : AppRoutes.signInRoot,
            routes: <String, WidgetBuilder>{
              AppRoutes.homeRoot: (context) => const HomePage(),
              AppRoutes.signInRoot: (context) => const SignInPage(),
              AppRoutes.signUpRoot: (context) => const SignUpPage(),
              AppRoutes.verifyEmailRoot: (context) => const VerifyEmailPage(),
            },
          ),
        ));
  }

  @override
  void dispose() {
    MyLocator.dispose();
    super.dispose();
  }
}
