import 'package:get_it/get_it.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_up/user_sign_up_entity.dart';

class DataProvider {
  final GetIt getIt = GetIt.instance;

  UserSignUpEntity getFileFromDomain() {
    return getIt.get();
  }
}
