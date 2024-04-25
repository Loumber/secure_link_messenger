import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepositoryImpl(this._firebaseAuth);


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


  Future<bool> isAuthenticated() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser!;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }


  @override
  Future<bool> signUp(String email, String name, String password, File photo) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
  
  @override
  Future<void> dischargePhoto(File imeage) {
    // TODO: implement dischargePhoto
    throw UnimplementedError();
  }
  
  @override
  Future<String> downloadPhotoUrl() {
    // TODO: implement downloadPhotoUrl
    throw UnimplementedError();
  }

}