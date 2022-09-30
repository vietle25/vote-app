import 'package:json_annotation/json_annotation.dart';
part 'feedback_filter.g.dart';

@JsonSerializable()
class FeedbackFilter {
  int? id; //id feedback
  String? content; //content feedback

  FeedbackFilter({this.id,this.content,});

  Map<String, dynamic> toJson() => _$FeedbackFilterToJson(this);
}