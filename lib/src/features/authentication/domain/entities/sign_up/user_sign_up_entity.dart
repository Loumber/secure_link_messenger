import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_sign_up_entity.freezed.dart';

@freezed
abstract class UserSignUpEntity with _$UserSignUpEntity {
   factory UserSignUpEntity({required String email, required String name,required String password, required File photo}) = _UserSignUpEntity;
}