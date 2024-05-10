part of 'contacts_bloc.dart';

sealed class ContactsState {}

final class ShowMyContacts extends ContactsState {}

final class SearchContacts extends ContactsState {}

final class SearchedContacts extends ContactsState {
  List<SearchedUserEntity> searchedUsers;

  SearchedContacts(this.searchedUsers);
}

final class AddToMyContacts extends ContactsState {}
