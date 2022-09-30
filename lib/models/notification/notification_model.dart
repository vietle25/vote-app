import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  int? id;
  String? titleVi;
  String? contentVi;
  String? titleEn;
  String? contentEn;
  int? type;
  String? createdAt;

  NotificationModel({
    this.id,
    this.titleVi,
    this.contentVi,
    this.titleEn,
    this.contentEn,
    this.type,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
