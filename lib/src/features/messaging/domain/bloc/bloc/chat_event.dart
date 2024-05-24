part of 'chat_bloc.dart';

sealed class ChatEvent {
  const ChatEvent();

  List<Object> get props => [];
}

class LoadChatsEvent extends ChatEvent {}
