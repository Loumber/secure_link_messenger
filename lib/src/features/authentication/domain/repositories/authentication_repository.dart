import 'dart:io';

abstract class AuthenticationRepository {
  
  Future<void> dischargePhoto(File imeage);
  Future<String> downloadPhotoUrl();
  Future<bool> checkUser(String email);
  Future<bool> signIn(String email, String password);
  Future<void> signUp();
}
