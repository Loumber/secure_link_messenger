import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_link_messenger/src/features/authentication/data/provider/data_provider.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthenticationRepositoryImpl implements AuthenticationRepository{
 

  final DataProvider _dataProvider = DataProvider();

  late User _currentUser;
  
  late String _imageURL;
  

  @override
  Future<bool> checkUser(String email) {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<void> signIn() async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _dataProvider.getSignInUserFromDomain().email,
      password: _dataProvider.getSignInUserFromDomain().email,
    );
    }on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e);
    }

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
        email: _dataProvider.getSignUpUserFromDomain().email, 
        password: _dataProvider.getSignUpUserFromDomain().password);

      _currentUser = FirebaseAuth.instance.currentUser!;
      
      await _currentUser.updateDisplayName(_dataProvider.getSignUpUserFromDomain().name);

      _imageURL = await dischargePhoto();
      
      _currentUser.updatePhotoURL(_imageURL);
    } on FirebaseAuthException catch(e){
      // ignore: avoid_print
      print(e);
    }
  }
  
  @override
Future<String> dischargePhoto() async {
  File file = _dataProvider.getSignUpUserFromDomain().photo; 
  try { 
    firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = storage.ref().child(file.path);
    await ref.putFile(file);

    return await ref.getDownloadURL();   
  } catch (e) {
    print(e);
  }
  return '';
}
  
  @override
  Future<String> downloadPhotoUrl() {
    // TODO: implement downloadPhotoUrl
    throw UnimplementedError();
  }

}