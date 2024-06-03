part of 'search_bloc.dart';

sealed class SearchState {}

final class InitialMessages extends SearchState {}

final class ShowMessages extends SearchState {
  List<ChatEntity> myContacts;
  ShowMessages(this.myContacts);
}

final class SearchMessages extends SearchState {}

final class SearchedMessages extends SearchState {
  List<ChatEntity> searchedUsers;

  SearchedMessages(this.searchedUsers);
}
