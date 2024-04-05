

abstract class FirebaseRepository {
  Future<bool> checkUser(String email);
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String name, String password);
}