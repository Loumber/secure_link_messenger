import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_sign_in_entity.freezed.dart';

@freezed
abstract class UserSignInEntity with _$UserSignInEntity {
  factory UserSignInEntity({required String email, required String password}) =
      _UserSignInEntity;
}
