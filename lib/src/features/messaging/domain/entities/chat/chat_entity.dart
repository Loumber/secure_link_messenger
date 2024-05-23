import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secure_link_messenger/src/features/messaging/domain/entities/message/message_entity.dart';

part 'chat_entity.freezed.dart';

@freezed
abstract class ChatEntity with _$ChatEntity {
  factory ChatEntity(
      {required String name,
      required String uid,
      required File avatar,
      required List<MessageEntity> messages}) = _ChatEntity;
}
