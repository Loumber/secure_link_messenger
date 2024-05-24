// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_link_messenger/src/features/account/domain/bloc/settings_bloc.dart';

class ChangeAvatarButton extends StatefulWidget {
  const ChangeAvatarButton({super.key});

  @override
  State<ChangeAvatarButton> createState() => _ChangeAvatarButtonState();
}

class _ChangeAvatarButtonState extends State<ChangeAvatarButton> {
  late File _newAvatar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: CupertinoButton(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.sp)),
          color: Colors.grey[200],
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext builder) {
                  return CupertinoPopupSurface(
                      child: Container(
                    color: CupertinoColors.white,
                    width: double.infinity,
                    height: 125.h,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        CupertinoButton(
                            child: Text(
                              'Камера',
                              style: TextStyle(
                                  fontSize: 25.sp, color: Colors.red[700]),
                            ),
                            onPressed: () async {
                              await _pickImageFromCamera();
                              Navigator.pop(context);
                              BlocProvider.of<SettingsBloc>(context).add(
                                  LoadingAvatarEvent(newAvatar: _newAvatar));
                            }),
                        Container(
                          height: 1.h,
                          color: Colors.red,
                          width: double.infinity,
                        ),
                        CupertinoButton(
                            child: Text(
                              'Галерея',
                              style: TextStyle(
                                  fontSize: 25.sp, color: Colors.red[700]),
                            ),
                            onPressed: () async {
                              await _pickImageFromGallery();
                              Navigator.pop(context);
                              BlocProvider.of<SettingsBloc>(context).add(
                                  LoadingAvatarEvent(newAvatar: _newAvatar));
                            }),
                      ],
                    ),
                  ));
                });
          },
          child: Text(
            'Изменить фото',
            style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
          )),
    );
  }

  Future _pickImageFromGallery() async {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage == null) {
      return;
    }
    setState(() {
      _newAvatar = File(selectedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImage == null) {
      return;
    }
    setState(() {
      _newAvatar = File(selectedImage.path);
    });
  }
}
