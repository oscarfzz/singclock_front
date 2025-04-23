// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    @JsonKey(name: "chat_id") required int chatId,
    String? name,
    @JsonKey(name: "created_by") required int createdBy,
    @JsonKey(name: "is_private") required bool isPrivate,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "not_readed") required int notReaded,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
