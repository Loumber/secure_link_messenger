import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class SuccessChangeAvatarDialog extends StatelessWidget {
  const SuccessChangeAvatarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Фото успешно изменено'),
      actions: [
        CupertinoButton(
            child: const Text('Ок'),
            onPressed: () {
              BlocProvider.of<SettingsBloc>(context)
                  .add(IsUpdatedAvatarEvent());
            })
      ],
    );
  }
}
