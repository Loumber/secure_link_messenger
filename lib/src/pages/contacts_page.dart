import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';
import 'package:secure_link_messenger/src/features/contacts/presentation/widgets/add_contacts.dart';
import 'package:secure_link_messenger/src/features/contacts/presentation/widgets/my_contacts.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
      switch (state) {
        case ShowMyContacts():
          return MyContacts(myContacts: state.myContacts);
        case SearchContacts():
          return const AddContactsPage();
        case AddToMyContacts():
          return Container();
        case SearchedContacts():
          return const AddContactsPage();
        case InitialContacts():
          return Padding(
            padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
            child: CupertinoTextField(
              onChanged: (value) {},
              padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
          );
      }
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
