import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class SuccessChangePasswordDialog extends StatelessWidget {
  const SuccessChangePasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Пароль успешно изменен'),
      actions: [
        CupertinoButton(
            child: const Text('Ок'),
            onPressed: () {
              BlocProvider.of<SettingsBloc>(context)
                  .add(IsRessetPasswordEvent());
            })
      ],
    );
  }
}
