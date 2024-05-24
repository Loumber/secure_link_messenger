import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class ChangeNameDialog extends StatefulWidget {
  const ChangeNameDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangeNameDialogState createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  final TextEditingController _newNameController = TextEditingController();

  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _newNameController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _newNameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _newNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Измените имя'),
      content: Column(
        children: [
          const SizedBox(height: 16),
          CupertinoTextField(
            onChanged: (value) {
              _updateButtonState();
            },
            controller: _newNameController,
            placeholder: 'Новое имя',
            placeholderStyle: TextStyle(color: Colors.grey[800]),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: _isButtonEnabled
              ? () {
                  BlocProvider.of<SettingsBloc>(context)
                      .add(LoadingNameEvent(newName: _newNameController.text));
                }
              : null,
          child: const Text('Ок'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context).add(IsUpdatedNameEvent());
          },
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
