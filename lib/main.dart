import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_link_messenger/firebase_options.dart';
import 'package:secure_link_messenger/app.dart';
import 'src/app/di.dart';

void main() async {
  await MyLocator.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}
