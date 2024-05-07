import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsAppBar extends StatefulWidget {
  const ContactsAppBar({super.key});

  @override
  State<ContactsAppBar> createState() => _ContactsAppBarState();
}

class _ContactsAppBarState extends State<ContactsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        const Text(
          'Контакты',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 100.w,
        ),
        GestureDetector(
          child: const Icon(Icons.add_rounded),
          onTap: () {},
        )
      ]),
    );
  }
}
