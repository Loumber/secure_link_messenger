import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';

@freezed
abstract class MessageEntity with _$MessageEntity {
  factory MessageEntity({
    required String message,
    required String dateTime,
    required String sender,
    required String recipient,
  }) = _MessageEntity;
}
