import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_link_messenger/src/features/authentication/data/provider/data_provider.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final DataProvider _dataProvider = DataProvider();

  final FirebaseAuth _firebaseAuth;

  late File _avatar;

  AuthenticationRepositoryImpl(
    this._firebaseAuth,
  );

  bool get isEmailVerification {
    if (isAuthorized) {
      if (_firebaseAuth.currentUser!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool get isAuthorized => _firebaseAuth.currentUser != null;

  User? get user => _firebaseAuth.currentUser;

  Stream<User?> get userStream => _firebaseAuth.userChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  late User _currentUser;

  late String _imageURL;

  @override
  Future<bool> checkUser(String email) {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      _currentUser = FirebaseAuth.instance.currentUser!;

      await _currentUser.updateDisplayName(name);
      sendEmailVerification();
      _imageURL = await dischargePhoto();

      _currentUser.updatePhotoURL(_imageURL);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void setImage(File avatar) {
    _avatar = avatar;
  }

  @override
  Future<String> dischargePhoto() async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref = storage.ref().child(_avatar.path);
      await ref.putFile(_avatar);

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

  @override
  Future<void> deleteCurrentUser() async {
    await _currentUser.delete();
  }

  @override
  void sendEmailVerification() {
    if (!_currentUser.emailVerified) {
      _currentUser.sendEmailVerification();
    }
  }
}
