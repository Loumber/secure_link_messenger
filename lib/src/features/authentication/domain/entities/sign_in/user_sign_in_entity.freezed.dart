// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_sign_in_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserSignInEntity {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserSignInEntityCopyWith<UserSignInEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSignInEntityCopyWith<$Res> {
  factory $UserSignInEntityCopyWith(
          UserSignInEntity value, $Res Function(UserSignInEntity) then) =
      _$UserSignInEntityCopyWithImpl<$Res, UserSignInEntity>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$UserSignInEntityCopyWithImpl<$Res, $Val extends UserSignInEntity>
    implements $UserSignInEntityCopyWith<$Res> {
  _$UserSignInEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSignInEntityImplCopyWith<$Res>
    implements $UserSignInEntityCopyWith<$Res> {
  factory _$$UserSignInEntityImplCopyWith(_$UserSignInEntityImpl value,
          $Res Function(_$UserSignInEntityImpl) then) =
      __$$UserSignInEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$UserSignInEntityImplCopyWithImpl<$Res>
    extends _$UserSignInEntityCopyWithImpl<$Res, _$UserSignInEntityImpl>
    implements _$$UserSignInEntityImplCopyWith<$Res> {
  __$$UserSignInEntityImplCopyWithImpl(_$UserSignInEntityImpl _value,
      $Res Function(_$UserSignInEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$UserSignInEntityImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserSignInEntityImpl implements _UserSignInEntity {
  _$UserSignInEntityImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'UserSignInEntity(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSignInEntityImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSignInEntityImplCopyWith<_$UserSignInEntityImpl> get copyWith =>
      __$$UserSignInEntityImplCopyWithImpl<_$UserSignInEntityImpl>(
          this, _$identity);
}

abstract class _UserSignInEntity implements UserSignInEntity {
  factory _UserSignInEntity(
      {required final String email,
      required final String password}) = _$UserSignInEntityImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$UserSignInEntityImplCopyWith<_$UserSignInEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
