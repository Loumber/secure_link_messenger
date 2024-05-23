abstract class AuthenticationRepository {
  Future<String> dischargePhoto(String name);
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password, String name);
  Future<void> deleteCurrentUser();
  void sendEmailVerification();
}
