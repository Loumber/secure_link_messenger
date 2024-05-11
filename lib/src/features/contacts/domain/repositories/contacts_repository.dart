import 'package:secure_link_messenger/src/features/contacts/domain/entities/searched_user_entity.dart';

abstract class ContactsRepository {
  Future<List<SearchedUserEntity>> searchUser(String userName);
}
