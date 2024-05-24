import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';
import 'package:secure_link_messenger/src/features/account/presentation/change_name_dialog.dart';
import 'package:secure_link_messenger/src/features/account/presentation/change_password_dialog.dart';
import 'package:secure_link_messenger/src/features/account/presentation/settings_buttons.dart';
import 'package:secure_link_messenger/src/features/account/presentation/success_change_avatar.dart';
import 'package:secure_link_messenger/src/features/account/presentation/success_change_name_dialog.dart';
import 'package:secure_link_messenger/src/features/account/presentation/success_change_password_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      switch (state) {
        case StartRessetPassword():
          return Stack(
            children: [
              const SettingsButtons(),
              Container(
                color: Colors.white38,
              ),
              const ChangePasswordDialog()
            ],
          );
        case LoadingRessetPassword():
          return const Center(child: CupertinoActivityIndicator());
        case LoadedRessetPassword():
          return Stack(
            children: [
              const SettingsButtons(),
              Container(
                color: Colors.white38,
              ),
              const SuccessChangePasswordDialog()
            ],
          );
        case SuccesChanges():
          return const SettingsButtons();
        case StartRessetName():
          return Stack(
            children: [
              const SettingsButtons(),
              Container(
                color: Colors.white38,
              ),
              const ChangeNameDialog()
            ],
          );
        case LoadingRessetName():
          return const Center(child: CupertinoActivityIndicator());
        case LoadedRessetName():
          return Stack(
            children: [
              const SettingsButtons(),
              Container(
                color: Colors.white38,
              ),
              const SuccessChangeNameDialog()
            ],
          );
        case LoadingNewAvatar():
          return const Center(child: CupertinoActivityIndicator());
        case LoadedNewAvatar():
          return Stack(
            children: [
              const SettingsButtons(),
              Container(
                color: Colors.white38,
              ),
              const SuccessChangeAvatarDialog()
            ],
          );
      }
    });
  }
}
