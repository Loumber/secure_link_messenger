import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
abstract class ContactEntity with _$ContactEntity {
  factory ContactEntity({required String cintactName, required File avatar}) =
      _ContactEntity;
}
