import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_link_messenger/src/features/authentication/data/provider/data_provider.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
 

  DataProvider _dataProvider = DataProvider();

  
  

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

/*

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

*/

  @override
  Future<void> signUp() async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _dataProvider.getUserFromDomain().email, 
        password: _dataProvider.getUserFromDomain().password);
      //await dischargePhoto(_dataProvider.getUserFromDomain().photo);
    } on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e);
    }
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