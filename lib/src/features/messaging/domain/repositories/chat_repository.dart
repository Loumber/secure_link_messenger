import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getUserChats();
}
