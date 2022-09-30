import 'package:json_annotation/json_annotation.dart';

part 'singer_model.g.dart';

@JsonSerializable()
class SingerModel {
  int id;
  String name;
  String? avatarPath;
  String? description;
  int? voteCount;
  bool voteStatus;
  String? path;

  SingerModel({
    required this.id,
    required this.name,
    this.avatarPath,
    this.description,
    this.voteCount,
    this.voteStatus = false,
    this.path,
  });

  factory SingerModel.fromJson(Map<String, dynamic> json) =>
      _$SingerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SingerModelToJson(this);
}
