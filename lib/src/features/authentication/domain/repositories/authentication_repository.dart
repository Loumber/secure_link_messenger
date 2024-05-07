abstract class AuthenticationRepository {
  Future<String> dischargePhoto();
  Future<String> downloadPhotoUrl();
  Future<bool> checkUser(String email);
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password, String name);
  Future<void> deleteCurrentUser();
  void sendEmailVerification();
}
