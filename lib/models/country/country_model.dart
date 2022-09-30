import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  int? id;
  String? name;
  String? subName;
  String? flag;
  String? phoneCode;

  CountryModel({
    this.id,
    this.name,
    this.subName,
    this.flag,
    this.phoneCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
