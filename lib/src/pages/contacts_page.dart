import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/bloc/contacts_bloc.dart';
import 'package:secure_link_messenger/src/features/contacts/presentation/widgets/add_contacts.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(builder: (context, state) {
      switch (state) {
        case ShowMyContacts():
          return Container();
        case SearchContacts():
          return const AddContactsPage();
        case AddToMyContacts():
          return Container();
      }
    });
  }
}
