import 'package:secure_link_messenger/src/features/messaging/data/chat_repository_impl.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/chat/chat_entity.dart';

class GetUserChats {
  final ChatRepositoryImpl repository;

  GetUserChats(this.repository);

  Stream<List<ChatEntity>> call() {
    return repository.getUserChats();
  }
}
