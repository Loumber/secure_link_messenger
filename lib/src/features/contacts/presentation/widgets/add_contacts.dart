import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
            onChanged: (value) {
              
            },
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
              child: Icon(
                Icons.person_4_outlined,
                size: 20.sp,
                color: getColorFromHex("#6C6C6D"),
              ),
            ),
          );
  }

   Color getColorFromHex(String hexColor) {
    var hex = hexColor.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
