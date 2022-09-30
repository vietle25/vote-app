import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  int? id;
  String? content;
  int? type;
  String? createdAt;
  int? fromUserId;
  int? timestamp;

  MessageModel({
    this.id,
    this.content,
    this.type,
    this.createdAt,
    this.timestamp,
    this.fromUserId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
