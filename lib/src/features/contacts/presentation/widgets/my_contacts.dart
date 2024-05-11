import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/entities/searched_user_entity.dart';
import 'package:secure_link_messenger/src/features/contacts/presentation/widgets/contact_card.dart';
import 'package:secure_link_messenger/src/features/contacts/presentation/widgets/searched_user.dart';

class MyContacts extends StatelessWidget {
  MyContacts({super.key, required this.myContacts});

  List<SearchedUserEntity> myContacts;

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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myContacts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContactCard(avatar: myContacts[index].avatar,
              name: myContacts[index].contactName,
              uId: myContacts[index].uId)
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
