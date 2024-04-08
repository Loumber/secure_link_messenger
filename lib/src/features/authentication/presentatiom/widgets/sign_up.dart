import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String name;
  late String email;
  late String password;
  late String confirmationPassword;
  File? image;
  bool isPasswordVisible = true;
  bool isConfirmationPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50 ,
            backgroundColor: image == null? Colors.red[700]:Colors.transparent,
            child: image != null
            ?
            ClipOval(
              child:SizedBox(
                width: 90.w,
                height: 90.h,
                child: Image.file(image!),
                )
            )
            :Stack(
                children: [
                  Center(
                    child: ClipOval(
                    child: Container(
                      width: 90,
                      height: 90,
                      color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      onPressed: (){
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext builder){
                            return  CupertinoPopupSurface(
                              child:Container(
                                color: CupertinoColors.white, 
                                width: double.infinity,                               
                                height: 125.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CupertinoButton(
                                      child: Text('Камера',
                                        style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.red[700] 
                                        ),
                                      ),
                                      onPressed: (){
                                        _pickImageFromCamera();
                                      }),
                                      Container(
                                        height: 1.h,
                                        color: Colors.red,
                                        width: double.infinity,
                                      ),
                                    CupertinoButton(
                                      child: Text('Галерея',
                                        style: TextStyle(
                                        fontSize: 25.sp,
                                        color: Colors.red[700]
                                        ),
                                      ),
                                      onPressed: (){
                                        _pickImageFromGallery();
                                      }),                                  
                                  ],
                                  ),
                              )
                            );
                          }
                        );
                      },
                      icon: Icon(Icons.photo_camera_front_outlined,
                        color:  Colors.red[700],
                        size: 50.sp,)
                      ),
                  ),
                ],
              ),
          ),
          SizedBox(
            height: 20.h,
          ),
          CupertinoTextField(
            onChanged: (value) {email=value;},
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'имя',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child:Icon(
              Icons.person_4_outlined,
              size: 20.sp,
              color: getColorFromHex("#6C6C6D"),
              ), 
            ),
            
          ),

          SizedBox(
            height: 15.h,
          ),

          CupertinoTextField(
            onChanged: (value) {email=value;},
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'почта',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child:Icon(
              Icons.alternate_email_outlined,
              size: 20.sp,
              color: getColorFromHex("#6C6C6D"),
              ), 
            ),
            
          ),
          SizedBox(
            height: 15.h,
          ),

          CupertinoTextField(            
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'пароль',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child:Icon(
              Icons.lock_outline,
              size: 20.sp,
              color: getColorFromHex("#6C6C6D"),
              ), 
            ),
            suffix: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
              child:IconButton(
                onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
                icon: isPasswordVisible 
                ? Icon(
                    Icons.visibility_off_outlined,
                    size: 20.sp,
                    color: getColorFromHex("#6C6C6D"),
                  )
                : Icon(
                    Icons.visibility_outlined,
                    size: 20.sp,
                    color: getColorFromHex("#6C6C6D"),
                  )
              ),
            ),
            obscureText: isPasswordVisible,
          ),

          SizedBox(
            height: 15.h,
          ),

          
          CupertinoTextField(            
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
            decoration: BoxDecoration(
              color: getColorFromHex('#E9E9E9'),
              borderRadius: BorderRadius.circular((10)),
            ),
            placeholder: 'пароль',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
              child:Icon(
              Icons.lock_outline,
              size: 20.sp,
              color: getColorFromHex("#6C6C6D"),
              ), 
            ),
            suffix: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
              child:IconButton(
                onPressed: () =>
                  setState(() => isConfirmationPasswordVisible = !isConfirmationPasswordVisible),
                icon: isConfirmationPasswordVisible 
                ? Icon(
                    Icons.visibility_off_outlined,
                    size: 20.sp,
                    color: getColorFromHex("#6C6C6D"),
                  )
                : Icon(
                    Icons.visibility_outlined,
                    size: 20.sp,
                    color: getColorFromHex("#6C6C6D"),
                  )
              ),
            ),
            obscureText: isConfirmationPasswordVisible,
          ),


          SizedBox(
            height: 20.h,
          ),
          CupertinoButton(
            borderRadius: BorderRadius.circular((36)),
            color: Colors.red[700],
            child: Text('Зарегестрироваться',
            style: TextStyle(
              fontSize: 18.sp,
            ),
            ),
            onPressed: (){
             
            })
        ],),
    );
  }

  bool isUnlockButton() {
    return password == confirmationPassword &&
        EmailValidator.validate(email)&&
        password.isNotEmpty &&
        confirmationPassword.isNotEmpty &&
        name.isNotEmpty;
  }


  Future _pickImageFromGallery() async{
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage  == null) {
      return;
    }
    setState(() {
      image = File(selectedImage.path);
    });
  }

  Future _pickImageFromCamera() async{
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImage  == null) {
      return;
    }
    setState(() {
      image = File(selectedImage.path);
    });
  }
  

  Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}