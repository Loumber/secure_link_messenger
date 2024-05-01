abstract class AuthenticationRepository {
  
  Future<String> dischargePhoto();
  Future<String> downloadPhotoUrl();
  Future<bool> checkUser(String email);
  Future<bool> signIn(String email, String password);
  Future<void> signUp();
}
