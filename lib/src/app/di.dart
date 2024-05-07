import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_link_messenger/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:secure_link_messenger/firebase_options.dart';
import 'package:flutter/material.dart';

abstract class MyLocator {
  static final _locator = GetIt.instance;

  static AuthenticationRepositoryImpl get userRepository =>
      _locator<AuthenticationRepositoryImpl>();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initFirebase();

    _locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    _locator.registerSingleton<AuthenticationRepositoryImpl>(
      AuthenticationRepositoryImpl(
        _locator<FirebaseAuth>(),
      ),
    );
  }

  static Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> dispose() async {}
}
