import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/account/presentation/avatar.dart';
import 'package:secure_link_messenger/src/features/account/presentation/change_avatar.dart';
import 'package:secure_link_messenger/src/features/account/presentation/change_name.dart';
import 'package:secure_link_messenger/src/features/account/presentation/delete_account.dart';
import 'package:secure_link_messenger/src/features/account/presentation/resset_password.dart';
import 'package:secure_link_messenger/src/features/account/presentation/sign_out.dart';

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Avatar(),
      SizedBox(
        height: 5.h,
      ),
      const ChangeAvatarButton(),
      Container(
        color: Colors.grey[600],
        height: 1.h,
        width: 350.w,
      ),
      const ChangeNameButton(),
      Container(
        color: Colors.grey[600],
        height: 1.h,
        width: 350.w,
      ),
      const RessetPasswordButton(),
      Container(
        color: Colors.grey[600],
        height: 1.h,
        width: 350.w,
      ),
      const SignOutBotton(),
      Container(
        color: Colors.grey[600],
        height: 1.h,
        width: 350.w,
      ),
      const DeleteAccount()
    ]));
  }
}
