part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {}

class SearchContactsEvent extends ContactsEvent {
  final String nameUser;

  SearchContactsEvent({required this.nameUser});
}

class AddContactsEvent extends ContactsEvent {}

class MyContactsEvent extends ContactsEvent {}
