import 'package:json_annotation/json_annotation.dart';

part 'user_device_model.g.dart';

@JsonSerializable()
class UserDeviceModel {
  int? id;
  String? deviceId;
  String? deviceToken;
  int? osType;

  UserDeviceModel({
    this.id,
    this.deviceId,
    this.deviceToken,
    this.osType,
  });

  factory UserDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$UserDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDeviceModelToJson(this);
}
