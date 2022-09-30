import 'package:json_annotation/json_annotation.dart';

part 'conversation_filter.g.dart';

@JsonSerializable()
class ConversationFilter {
  String? content;
  int? typeMessage;

  ConversationFilter({
    this.content,
    this.typeMessage,
  });

  factory ConversationFilter.fromJson(Map<String, dynamic> json) =>
      _$ConversationFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationFilterToJson(this);
}
