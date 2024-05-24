import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _currentPasswordController.text.isNotEmpty &&
          _newPasswordController.text == _confirmPasswordController.text &&
          _newPasswordController.text.length >= 6;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_updateButtonState);
    _newPasswordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Измените текущий пароль'),
      content: Column(
        children: [
          const SizedBox(height: 16),
          CupertinoTextField(
            onChanged: (value) {
              var logger = Logger(
                printer: PrettyPrinter(),
              );

              _updateButtonState();
              logger.d(_isButtonEnabled);
            },
            controller: _currentPasswordController,
            placeholder: 'Текущий пароль',
            placeholderStyle: TextStyle(color: Colors.grey[800]),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            onChanged: (value) {
              var logger = Logger(
                printer: PrettyPrinter(),
              );

              _updateButtonState();
              logger.d(_isButtonEnabled);
            },
            controller: _newPasswordController,
            placeholderStyle: TextStyle(color: Colors.grey[800]),
            placeholder: 'Новый пароль',
            obscureText: true,
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            onChanged: (value) {
              var logger = Logger(
                printer: PrettyPrinter(),
              );
              _updateButtonState();
              logger.d(_isButtonEnabled);
            },
            controller: _confirmPasswordController,
            placeholder: 'Подтвердите новый пароль',
            placeholderStyle: TextStyle(color: Colors.grey[800]),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: _isButtonEnabled
              ? () {
                  BlocProvider.of<SettingsBloc>(context).add(
                    LoadingPasswordEvent(
                      currentPassword: _currentPasswordController.text,
                      newPassword: _newPasswordController.text,
                    ),
                  );
                }
              : null,
          child: const Text('Ок'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context).add(IsRessetPasswordEvent());
          },
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
