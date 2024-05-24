import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/core/navigation/app_routes.dart';
import 'package:secure_link_messenger/src/features/app_bar/presentation/contacts_app_bar.dart';
import 'package:secure_link_messenger/src/features/app_bar/presentation/message_app_bar.dart';
import 'package:secure_link_messenger/src/features/app_bar/presentation/settings_app_bar.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/data/providers/page_provider.dart';
import 'package:secure_link_messenger/src/pages/contacts_page.dart';
import 'package:secure_link_messenger/src/pages/message_page.dart';
import 'package:secure_link_messenger/src/pages/settings_page.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/bloc/bloc/authentication_bloc.dart';
import 'package:secure_link_messenger/src/features/navigation_bar/presentation/navigation_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final PageStorageBucket _bucket = PageStorageBucket();

  List<Widget> pages = [
    const ContactsPage(key: PageStorageKey('Contacts_page')),
    const MessagePage(key: PageStorageKey('Message_page')),
    const SettingsPage(key: PageStorageKey('Settings_page'))
  ];

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d('Homepage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: ref.watch(pageProvider) == 0
              ? const ContactsAppBar()
              : ref.watch(pageProvider) == 1
                  ? const MessageAppBar()
                  : const SettingsAppBar()),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        switch (state) {
          case AuthenticationInitial():
            myLoggr('AuthenticationInitial');
            return const Placeholder();
          case SignUpInitial():
            myLoggr('SignUpInitial');
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.signInRoot, (route) => false);
            return const Placeholder();
          case SignInInitial():
            myLoggr('SignInInitial');
            return const CupertinoActivityIndicator();
          case SignUpLoading():
            myLoggr('SignUpInitial');
            return const CupertinoActivityIndicator();
          case SignInLoading():
            myLoggr('SignInLoading');
            return const CupertinoActivityIndicator();
          case SignUpEmailVerify():
            myLoggr('SignUpEmailVerify');
            return const CupertinoActivityIndicator();
          case IsAuthentication():
            myLoggr('IsAuthentication');
            return PageStorage(
                bucket: _bucket, child: pages[ref.watch(pageProvider)]);
          case SignUpError():
            myLoggr('SignUpError');
            return const Placeholder();
          case SignInError():
            myLoggr('SignInError');
            return const Placeholder();
        }
      }),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }

  void myLoggr(String str) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(str);
  }
}
