import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable()
class LanguageModel {
  String name;
  String code;
  String countryCode;
  String localesCode;
  String flag;

  LanguageModel({
    required this.name,
    required this.code,
    required this.countryCode,
    required this.localesCode,
    required this.flag,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageModelToJson(this);
}
