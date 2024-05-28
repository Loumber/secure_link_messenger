part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchMessageEvent extends SearchEvent {
  final String nameUser;
  final List<ChatEntity> messages;
  SearchMessageEvent(this.messages, {required this.nameUser});
}

class MyMessageEvent extends SearchEvent {}
