import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'package:secure_link_messenger/src/features/messaging/presentation/widgets/chat_card.dart';

// ignore: must_be_immutable
class MyChats extends StatelessWidget {
  List<ChatEntity> myChats;

  MyChats({super.key, required this.myChats});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
          child: CupertinoTextField(
            onChanged: (value) {},
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
        SizedBox(
          height: 10.h,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myChats.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatCard(
                  uid: myChats[index].uid,
                  name: myChats[index].name,
                  avatar: myChats[index].avatar,
                  dateTime: myChats[index]
                      .messages[myChats[index].messages.length - 1]
                      .dateTime,
                  lastMessage: myChats[index]
                      .messages[myChats[index].messages.length - 1]
                      .message,
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 5.h,
              indent: 15.w,
              endIndent: 15.w,
            );
          },
        )
      ],
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
