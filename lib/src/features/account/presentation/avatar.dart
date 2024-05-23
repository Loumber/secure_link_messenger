import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late Future<File> _avatarFuture;

  @override
  void initState() {
    super.initState();
    _avatarFuture = getCurrentUserAvatar();
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
            child: Image(
              image: FileImage(snapshot.data!),
              fit: BoxFit.cover,
            ));
        } else {
          return const Text('No avatar found');
        }
      },
    );
  }

  Future<File> getCurrentUserAvatar() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('User is not logged in');
    }

    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    final userData = userSnapshot.data();

    if (userData == null || !userData.containsKey('imageUrl')) {
      throw Exception('User is not logged in');
    }

    final String avatarUrl = userData['imageUrl'];

    final directory = await getApplicationDocumentsDirectory();
    final avatarPath = '${directory.path}/${currentUser.uid}-avatar.jpg';
    final avatarFile = File(avatarPath);

    if (!avatarFile.existsSync()) {
      final response = await http.get(Uri.parse(avatarUrl));
      avatarFile.writeAsBytesSync(response.bodyBytes);
    }

    return avatarFile;
  }
}
