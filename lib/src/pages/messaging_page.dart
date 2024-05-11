import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage(
      {super.key, required this.name, required this.avatar, required this.uId});

  final String name;
  final File avatar;
  final String uId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.sp,
              child: ClipOval(
                  child: SizedBox(
                      height: 90.h, width: 90.w, child: Image.file(avatar))),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      ),

      body: 
              
                Padding(
                            padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                            child: Align(
                alignment: Alignment.bottomCenter,
                child: CupertinoTextField(
                  onChanged: (value) {
                   
                  },
                  padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular((10)),
                  ),
                  placeholder: 'Найти',
                  placeholderStyle: TextStyle(
                    color: getColorFromHex("#6C6C6D"),
                  ),
                  style: TextStyle(
                    color: getColorFromHex("#6C6C6D"),
                  ),
                  prefix: Padding(
                    padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
                    child: Icon(
                      Icons.search_rounded,
                      size: 20.sp,
                      color: getColorFromHex("#6C6C6D"),
                    ),
                  ),
                ),
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
