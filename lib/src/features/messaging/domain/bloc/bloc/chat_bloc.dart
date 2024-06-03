import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/use_case/get_user_chats.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUserChats getUserChats;

  ChatBloc(this.getUserChats) : super(ChatInitial()) {
    on<LoadChatsEvent>((event, emit) async {
      emit(ChatLoading());
      try {
        final chatsStream = getUserChats();
        await emit.forEach<List<ChatEntity>>(
          chatsStream,
          onData: (chats) => ChatLoaded(chats: chats),
          onError: (error, stackTrace) {
            var logger = Logger(
              printer: PrettyPrinter(),
            );
            logger.d(error);
            logger.e(stackTrace);
            return ChatError(message: error.toString());
          },
        );
      } catch (e, stackTrace) {
        var logger = Logger(
          printer: PrettyPrinter(),
        );
        logger.d(e);
        logger.e(stackTrace);
        emit(ChatError(message: e.toString()));
      }
    });
  }
}
