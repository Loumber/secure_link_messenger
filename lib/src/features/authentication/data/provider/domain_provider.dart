import 'package:get_it/get_it.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_up/user_sign_up_entity.dart';

class DomainProvider {
  final GetIt getIt = GetIt.instance;

  void registerSignUpUser(UserSignUpEntity file) {
    getIt.registerSingleton(file);
  }
}