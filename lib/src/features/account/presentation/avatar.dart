import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:secure_link_messenger/src/features/account/presentation/user_name.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late Future<File> _avatarFuture;
  Timer? _retryTimer;
  static const int _retryIntervalSeconds = 2; // интервал в секундах

  @override
  void initState() {
    super.initState();
    _avatarFuture = getCurrentUserAvatarWithRetries();
  }

  Future<File> getCurrentUserAvatarWithRetries() async {
    return _fetchCurrentUserAndAvatar();
  }

  Future<File> _fetchCurrentUserAndAvatar() async {
    Completer<File> completer = Completer<File>();

    _retryTimer = Timer.periodic(const Duration(seconds: _retryIntervalSeconds), (timer) async {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          File avatarFile = await _fetchUserAvatar(currentUser.uid);
          if (avatarFile.existsSync()) {
            completer.complete(avatarFile);
            timer.cancel();
          }
        }
      } catch (e) {
      }
    });

    return completer.future;
  }

  Future<File> _fetchUserAvatar(String uid) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final userData = userSnapshot.data();

    if (userData == null || !userData.containsKey('imageUrl')) {
      throw Exception('User data not found');
    }

    final String avatarUrl = userData['imageUrl'];

    final directory = await getApplicationDocumentsDirectory();
    final avatarPath = '${directory.path}/$uid-avatar.jpg';
    final avatarFile = File(avatarPath);

    
      final response = await http.get(Uri.parse(avatarUrl));
      avatarFile.writeAsBytesSync(response.bodyBytes);
    

    return avatarFile;
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _avatarFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 420,
                width: 420,
            child: Stack(
              children: [SizedBox(
                height: 420,
                width: 420,
                child: Image(
                  image: FileImage(snapshot.data!),
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: UserName())
              ]
            ),
          );
        } else {
          return const Text('No avatar found');
        }
      },
    );
  }
}
