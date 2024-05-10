part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState {}

final class ShowMyContacts extends ContactsState {}

final class SearchContacts extends ContactsState {}

final class AddToMyContacts extends ContactsState {}
