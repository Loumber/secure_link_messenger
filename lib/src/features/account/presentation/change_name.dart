import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class ChangeNameButton extends StatelessWidget {
  const ChangeNameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: CupertinoButton(
          borderRadius: BorderRadius.circular((0)),
          color: Colors.grey[200],
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context).add(GoUpdateNameEvent());
          },
          child: Text(
            'Изменить имя',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
          )),
    );
  }
}
