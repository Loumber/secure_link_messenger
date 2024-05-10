import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';

class ContactsAppBar extends StatefulWidget {
  const ContactsAppBar({super.key});

  @override
  State<ContactsAppBar> createState() => _ContactsAppBarState();
}

class _ContactsAppBarState extends State<ContactsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text(
        'Контакты',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 100.w,
      ),
      GestureDetector(
        child: const Icon(Icons.add_rounded),
        onTap: () {
          BlocProvider.of<ContactsBloc>(context)
                        .add(AddContactsEvent());
        },
      )
    ]);
  }
}
