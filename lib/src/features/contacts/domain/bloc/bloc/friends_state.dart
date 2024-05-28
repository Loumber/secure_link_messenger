part of 'friends_bloc.dart';

sealed class FriendsState {}

final class InitialFriends extends FriendsState {}

final class ShowMyFriends extends FriendsState {
  List<SearchedUserEntity> myContacts;

  ShowMyFriends(this.myContacts);
}

final class SearchFriends extends FriendsState {}

final class SearchedFriends extends FriendsState {
  List<SearchedUserEntity> searchedUsers;

  SearchedFriends(this.searchedUsers);
}
