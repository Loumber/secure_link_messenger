part of 'friends_bloc.dart';

@immutable
sealed class FriendsEvent {}

class SearchFriendEvent extends FriendsEvent {
  final String nameUser;
  final List<SearchedUserEntity> friends;
  SearchFriendEvent(this.friends, {required this.nameUser});
}

class MyFriendEvent extends FriendsEvent {}
