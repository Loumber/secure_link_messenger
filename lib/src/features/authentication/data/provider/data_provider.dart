import 'package:get_it/get_it.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_in/user_sign_in_entity.dart';

class DataProvider {
  final GetIt getIt = GetIt.instance;

  UserSignInEntity getSignInUserFromDomain() {
    return getIt.get();
  }
}
