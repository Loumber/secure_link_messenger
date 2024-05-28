import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/use_case/get_user_chats.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetUserChats getUserChats;

  SearchBloc(this.getUserChats) : super(InitialMessages()) {
    on<SearchMessageEvent>((event, emit) {
      emit(SearchMessages());
      List<ChatEntity> messages = getUserChats.repository
          .searchMessages(event.nameUser, event.messages);
      emit(SearchedMessages(messages));
    });

    on<MyMessageEvent>((event, emit) {
      emit(InitialMessages());
    });
  }
}
