import 'package:get_it/get_it.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_in/user_sign_in_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_up/user_sign_up_entity.dart';

class DataProvider {
  final GetIt getIt = GetIt.instance;

  UserSignInEntity getSignInUserFromDomain() {
    return getIt.get();
  }
}
