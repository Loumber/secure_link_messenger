// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_sign_up_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserSignUpEntity {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  File get photo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserSignUpEntityCopyWith<UserSignUpEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSignUpEntityCopyWith<$Res> {
  factory $UserSignUpEntityCopyWith(
          UserSignUpEntity value, $Res Function(UserSignUpEntity) then) =
      _$UserSignUpEntityCopyWithImpl<$Res, UserSignUpEntity>;
  @useResult
  $Res call({String email, String name, String password, File photo});
}

/// @nodoc
class _$UserSignUpEntityCopyWithImpl<$Res, $Val extends UserSignUpEntity>
    implements $UserSignUpEntityCopyWith<$Res> {
  _$UserSignUpEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? password = null,
    Object? photo = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as File,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSignUpEntityImplCopyWith<$Res>
    implements $UserSignUpEntityCopyWith<$Res> {
  factory _$$UserSignUpEntityImplCopyWith(_$UserSignUpEntityImpl value,
          $Res Function(_$UserSignUpEntityImpl) then) =
      __$$UserSignUpEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String name, String password, File photo});
}

/// @nodoc
class __$$UserSignUpEntityImplCopyWithImpl<$Res>
    extends _$UserSignUpEntityCopyWithImpl<$Res, _$UserSignUpEntityImpl>
    implements _$$UserSignUpEntityImplCopyWith<$Res> {
  __$$UserSignUpEntityImplCopyWithImpl(_$UserSignUpEntityImpl _value,
      $Res Function(_$UserSignUpEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? password = null,
    Object? photo = null,
  }) {
    return _then(_$UserSignUpEntityImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }
}

/// @nodoc

class _$UserSignUpEntityImpl implements _UserSignUpEntity {
  _$UserSignUpEntityImpl(
      {required this.email,
      required this.name,
      required this.password,
      required this.photo});

  @override
  final String email;
  @override
  final String name;
  @override
  final String password;
  @override
  final File photo;

  @override
  String toString() {
    return 'UserSignUpEntity(email: $email, name: $name, password: $password, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSignUpEntityImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, name, password, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSignUpEntityImplCopyWith<_$UserSignUpEntityImpl> get copyWith =>
      __$$UserSignUpEntityImplCopyWithImpl<_$UserSignUpEntityImpl>(
          this, _$identity);
}

abstract class _UserSignUpEntity implements UserSignUpEntity {
  factory _UserSignUpEntity(
      {required final String email,
      required final String name,
      required final String password,
      required final File photo}) = _$UserSignUpEntityImpl;

  @override
  String get email;
  @override
  String get name;
  @override
  String get password;
  @override
  File get photo;
  @override
  @JsonKey(ignore: true)
  _$$UserSignUpEntityImplCopyWith<_$UserSignUpEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
