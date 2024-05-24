import 'package:flutter/material.dart';

class SettingsAppBar extends StatefulWidget {
  const SettingsAppBar({super.key});

  @override
  State<SettingsAppBar> createState() => _SettingsAppBarState();
}

class _SettingsAppBarState extends State<SettingsAppBar> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Настройки',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
