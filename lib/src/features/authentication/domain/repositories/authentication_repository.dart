import 'dart:io';

abstract class AuthenticationRepository {
  
  Future<void> dischargePhoto(File imeage);
  Future<String> downloadPhotoUrl();
  Future<bool> checkUser(String email);
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String name, String password, File photo);
}
