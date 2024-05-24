import 'dart:io';

abstract class AuthenticationRepository {
  Future<String> dischargePhoto(String name);
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password, String name);
  Future<void> deleteCurrentUser();
  void sendEmailVerification();
  Future<void> updateProfilePicture(File newAvatar);
  Future<void> updateUserName(String newName);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<String> getCurrentUserName();
}
