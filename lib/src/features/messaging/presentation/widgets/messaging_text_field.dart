import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingTextField extends StatefulWidget {
  const MessagingTextField({super.key});

  @override
  State<MessagingTextField> createState() => _MessagingTextFieldState();
}

class _MessagingTextFieldState extends State<MessagingTextField> {
  @override
  Widget build(BuildContext context) {
    return Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 0),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Устанавливаем минимальный размер по главной оси
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: CupertinoTextField(
            onChanged: (value) {},
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(10),
            ),
            placeholder: 'Сообщение',
            placeholderStyle: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
            style: TextStyle(
              color: getColorFromHex("#6C6C6D"),
            ),
          ),
        ),
        CupertinoButton(
          child: Icon(Icons.send_rounded, color: Colors.red[900]),
          onPressed: () {},
        ),
      ],
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
