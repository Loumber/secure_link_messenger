abstract class AuthenticationRepository {
  
  Future<String> dischargePhoto();
  Future<String> downloadPhotoUrl();
  Future<bool> checkUser(String email);
  Future<void> signIn();
  Future<void> signUp();
}
