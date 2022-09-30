import 'package:flutter_app/models/notification/notification_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_target_model.g.dart';

@JsonSerializable()
class NotificationTargetModel {
  int? id;
  bool isSeen;
  NotificationModel? notification;
  String? createdAt;

  NotificationTargetModel({
    this.id,
    this.notification,
    this.isSeen = false,
    this.createdAt,
  });

  static NotificationTargetModel fromJson(Map<String, dynamic> json) {
    return NotificationTargetModel(
      id: json['id'] as int?,
      notification: json['notification'] == null
          ? null
          : NotificationModel.fromJson(
              json['notification'] as Map<String, dynamic>),
      isSeen: json['seen'] != null ? json['seen'] as bool : false,
      createdAt: json['createdAt'] as String?,
    );
  }

  // factory NotificationTargetModel.fromJson(Map<String, dynamic> json) =>
  //     _$NotificationTargetModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTargetModelToJson(this);
}
