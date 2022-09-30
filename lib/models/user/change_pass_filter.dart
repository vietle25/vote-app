import 'package:json_annotation/json_annotation.dart';
part 'change_pass_filter.g.dart';

@JsonSerializable()
class ChangePassFilter {
  String? newPassword; //new Password
  String? oldPassword; //new Password


  ChangePassFilter({this.newPassword,this.oldPassword,});

  Map<String, dynamic> toJson() => _$ChangePassFilterToJson(this);
}