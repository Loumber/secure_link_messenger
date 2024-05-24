import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/app/di.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  late Future<String> _userNameFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = MyLocator.userRepository.getCurrentUserName();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _userNameFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(snapshot.data);
          return 
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    snapshot.data!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30
                    ),
                  ),
                ],
              );
        } else {
          return const Text('No user name found');
        }
      },
    );
  }
}
