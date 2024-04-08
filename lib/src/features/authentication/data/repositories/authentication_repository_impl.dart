import 'dart:io';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
  @override
  Future<bool> checkUser(String email) {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<bool> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<bool> signUp(String email, String name, String password, File photo) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

}