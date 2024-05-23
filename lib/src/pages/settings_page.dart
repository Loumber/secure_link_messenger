import 'package:flutter/material.dart';
import 'package:secure_link_messenger/src/features/account/presentation/avatar.dart';
import 'package:secure_link_messenger/src/features/account/presentation/sign_out.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(children: [Avatar(), SignOutBotton()]),
    );
  }
}
