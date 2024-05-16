import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/entities/searched_user_entity.dart';
import 'package:secure_link_messenger/src/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final FirebaseAuth _firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;
  late Map<String, dynamic> userMap;
  ContactsRepositoryImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Future<List<SearchedUserEntity>> searchUser(String userName) async {
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    List<SearchedUserEntity> searchedUsers = [];
    logger.d('Я на месте');
    var querySnapshot = await _firebaseFirestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: userName)
        .where('name', isLessThan: userName + 'z')
        .get();
    for (var doc in querySnapshot.docs) {
      // if (doc.id != _firebaseAuth.currentUser!.uid) {
      var photo = await downloadPhoto(doc.data()['imageUrl']);
      var user = SearchedUserEntity(
        contactName: doc.data()['name'],
        avatar: photo,
        uId: doc.id,
      );
      searchedUsers.add(user);
      //}
    }
    return searchedUsers;
  }

  Future<bool> isFriend(String uId) async {
    var currentUserDoc = await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    var friendsList = currentUserDoc.data()?['friends'] ?? [];
    return friendsList.contains(uId);
  }

  Future<void> addFriend(String uId) async {
    bool flag = await isFriend(uId);
    if (!flag) {
      var currentUserDoc = await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      var friendsList = currentUserDoc.data()?['friends'] ?? [];
      friendsList.add(uId);
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        'friends': friendsList,
      });
    }
  }

  Future<List<SearchedUserEntity>> getFriendList() async {
    try {
      var logger = Logger(
        printer: PrettyPrinter(),
      );
      logger.d('Ущу друзей');
      var currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      if (currentUserDoc.exists) {
        var friendsList = currentUserDoc.data()?['friends'] ?? [];
        List<SearchedUserEntity> friendEntities = [];
        for (var friendUid in friendsList) {
          var friendDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(friendUid)
              .get();
          if (friendDoc.exists) {
            var friendData = friendDoc.data();
            logger.d(friendData?['name']);
            var friend = SearchedUserEntity(
              contactName: friendData?['name'],
              avatar: await downloadPhoto(friendData?['imageUrl']),
              uId: friendUid,
            );
            friendEntities.add(friend);
          }
        }
        return friendEntities;
      } else {
        print('Текущий пользователь не найден в базе данных');
        return [];
      }
    } catch (e) {
      print('Ошибка при получении списка друзей: $e');
      return [];
    }
  }

  Future<File> downloadPhoto(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final appDir = await getApplicationDocumentsDirectory();
      final file =
          File('${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      throw e;
    }
  }
}
