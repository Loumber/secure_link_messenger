import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
   factory UserEntity({required String email, required String name,required String password, required File photo, required List<UserEntity> contacts}) = _UserEntity;
}