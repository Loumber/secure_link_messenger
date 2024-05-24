import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class SuccessChangeNameDialog extends StatelessWidget {
  const SuccessChangeNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Имя успешно изменено'),
      actions: [
        CupertinoButton(
            child: const Text('Ок'),
            onPressed: () {
              BlocProvider.of<SettingsBloc>(context).add(IsUpdatedNameEvent());
            })
      ],
    );
  }
}
