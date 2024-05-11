part of 'contacts_bloc.dart';

sealed class ContactsState {}

final class InitialContacts extends ContactsState {}

final class ShowMyContacts extends ContactsState {
  List<SearchedUserEntity> myContacts;

  ShowMyContacts(this.myContacts);
}

final class SearchContacts extends ContactsState {}

final class SearchedContacts extends ContactsState {
  List<SearchedUserEntity> searchedUsers;

  SearchedContacts(this.searchedUsers);
}

final class AddToMyContacts extends ContactsState {}
