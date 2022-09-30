import 'package:json_annotation/json_annotation.dart';

part 'config_model.g.dart';

@JsonSerializable()
class ConfigModel {
  String? name;
  int? id;
  String? textValue;
  double? numericValue; // Numeric

  ConfigModel({this.name, this.textValue, this.id, this.numericValue});

  factory ConfigModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelToJson(this);
}
