import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
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

  late Widget _currentPage;

  List<Widget> pages = [
    const ContactsPage(key: PageStorageKey('Contacts_page')),
    const MessagePage(key: PageStorageKey('Message_page')),
    const SettingsPage(key: PageStorageKey('Settings_page'))
  ];

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
              MyLoggr('AuthenticationInitial');
              return const Placeholder();
            case SignUpInitial():
              MyLoggr('SignUpInitial');
              return const Placeholder();
            case SignInInitial():
              MyLoggr('SignInInitial');
              return const Placeholder();
            case SignUpLoading():
              MyLoggr('SignUpInitial');
              return const CupertinoActivityIndicator();
            case SignInLoading():
              MyLoggr('SignInLoading');
              return const CupertinoActivityIndicator();
            case SignUpEmailVerify():
              MyLoggr('SignUpEmailVerify');
              return const CupertinoActivityIndicator();
            case IsAuthentication():
              MyLoggr('IsAuthentication');
              return PageStorage(
                  bucket: _bucket, 
                  child: pages[ref.watch(pageProvider)]);
            case SignUpError():
              MyLoggr('SignUpError');
              return const Placeholder();
          }
        }),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }

  void MyLoggr(String str){
    var logger = Logger(
            printer: PrettyPrinter(),
    );
    logger.d(str);
  }
}
