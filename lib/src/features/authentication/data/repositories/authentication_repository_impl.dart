import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:crypton/crypton.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  late File _avatar;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  AuthenticationRepositoryImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  bool get isEmailVerification {
    if (isAuthorized) {
      return _firebaseAuth.currentUser!.emailVerified;
    }
    return false;
  }

  File get avatar => _avatar;
  bool get isAuthorized => _firebaseAuth.currentUser != null;
  User? get user => _firebaseAuth.currentUser;
  Stream<User?> get userStream => _firebaseAuth.userChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  late User _currentUser;
  late String _imageURL;

  late RSAPrivateKey _myRsaPrivateKey;
  late RSAPublicKey _myRsaPublicKey;

  @override
  Future<void> signIn(String email, String password) async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    logger.d(email);
    logger.d(password);
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    await _retrievePrivateKey();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _currentUser = FirebaseAuth.instance.currentUser!;
      await _currentUser.updateDisplayName(name);
      sendEmailVerification();
      _imageURL = await dischargePhoto(_currentUser.uid);
      await _currentUser.updatePhotoURL(_imageURL);

      // Generate RSA keypair
      var myRsaKeypair = RSAKeypair.fromRandom();

      logger.d(myRsaKeypair.publicKey);
      logger.d(myRsaKeypair.privateKey);
      var myRsaPublicKeyString = myRsaKeypair.publicKey.toPEM();
      var myRsaPrivateKeyString = myRsaKeypair.privateKey.toPEM();

      await _firebaseFirestore.collection('users').doc(_currentUser.uid).set({
        'name': name,
        'email': _currentUser.email,
        'status': 'Soon',
        'imageUrl': _imageURL,
        'friends': [],
        'chats': [],
        'publicKey': myRsaPublicKeyString,
        'privateKey': myRsaPrivateKeyString,
      });
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void setImage(File avatar) {
    _avatar = avatar;
  }

  @override
  Future<String> dischargePhoto(String name) async {
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      String fileName = basename(_avatar.path);
      firebase_storage.Reference ref = storage.ref().child(name + fileName);
      await ref.putFile(_avatar);
      return await ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> deleteCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
    final userSnapshot = await userDoc.get();
    if (!userSnapshot.exists) {
      throw Exception('User data not found in Firestore');
    }

    final userData = userSnapshot.data()!;
    final avatarUrl = userData['imageUrl'] as String?;
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      try {
        final firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.refFromURL(avatarUrl);
        await ref.delete();
      } catch (e) {
        rethrow;
      }
    }

    try {
      await userDoc.delete();
    } catch (e) {
      rethrow;
    }

    try {
      await currentUser.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void sendEmailVerification() {
    if (!_currentUser.emailVerified) {
      _currentUser.sendEmailVerification();
    }
  }

  @override
  Future<void> updateUserName(String newName) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    try {
      await currentUser.updateDisplayName(newName);
      final userDoc =
          _firebaseFirestore.collection('users').doc(currentUser.uid);
      await userDoc.update({'name': newName});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfilePicture(File newAvatar) async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    final userDoc = _firebaseFirestore.collection('users').doc(currentUser.uid);
    final userSnapshot = await userDoc.get();
    if (!userSnapshot.exists) {
      throw Exception('User data not found in Firestore');
    }

    final userData = userSnapshot.data()!;
    final oldAvatarUrl = userData['imageUrl'] as String?;
    if (oldAvatarUrl != null && oldAvatarUrl.isNotEmpty) {
      try {
        final firebase_storage.Reference oldRef =
            firebase_storage.FirebaseStorage.instance.refFromURL(oldAvatarUrl);
        await oldRef.delete();
      } catch (e) {
        throw Exception('Failed to delete old avatar: $e');
      }
    }

    final newAvatarFileName = basename(newAvatar.path);
    final firebase_storage.Reference newRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(currentUser.uid)
        .child(newAvatarFileName);
    try {
      await newRef.putFile(newAvatar);
      final newAvatarUrl = await newRef.getDownloadURL();
      await currentUser.updatePhotoURL(newAvatarUrl);
      await userDoc.update({'imageUrl': newAvatarUrl});
    } catch (e) {
      throw Exception('Failed to upload new avatar: $e');
    }
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      final credential = EmailAuthProvider.credential(
          email: currentUser!.email!, password: currentPassword);
      await currentUser.reauthenticateWithCredential(credential);
      await currentUser.updatePassword(newPassword);
      Logger().d('Password changed successfully');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getCurrentUserName() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();
    final userData = userSnapshot.data();
    if (userData == null || !userData.containsKey('name')) {
      throw Exception('User data not found');
    }
    return userData['name'] as String;
  }

  Future<void> _retrievePrivateKey() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('User is not logged in');
    }
    final userDoc =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();
    _myRsaPublicKey = RSAPublicKey.fromPEM(userDoc['publicKey']);
    _myRsaPrivateKey = RSAPrivateKey.fromPEM(userDoc['privateKey']);
    Logger().d('Private Key retrieved successfully');
  }
}
