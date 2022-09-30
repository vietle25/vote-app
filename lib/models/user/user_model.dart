import 'package:flutter_app/models/country/country_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? fbId;
  String? ggId;
  int? gender;
  String? token;
  String? rememberToken;
  String? dob;
  String? email;
  int? userType;
  String? avatar;
  int? status;
  String? firebaseToken;
  double? longitude, latitude;
  String? createdAt;
  String? code;
  String? password;
  String? phoneCode;
  int? errorCode;
  int? countryId;
  String? socialId;
  String? loginType;
  int? documentType;
  int? verificationStatus;
  String? reasonRejected;
  String? legalName;
  String? documentId;
  String? firstVerifyImage;
  String? secondVerifyImage;
  bool? hasPassword;
  CountryModel? country;
  String? pinCode;
  bool? activePin = false;
  bool? deleting = false;
  String? willDeleteAt;
  String? requestDeleteAt;

  UserModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.fbId,
    this.ggId,
    this.gender,
    this.token,
    this.rememberToken,
    this.dob,
    this.email,
    this.userType,
    this.avatar,
    this.status,
    this.firebaseToken,
    this.longitude,
    this.latitude,
    this.code,
    this.createdAt,
    this.password,
    this.phoneCode,
    this.errorCode,
    this.countryId,
    this.socialId,
    this.loginType,
    this.documentType,
    this.verificationStatus,
    this.reasonRejected,
    this.legalName,
    this.documentId,
    this.firstVerifyImage,
    this.secondVerifyImage,
    this.hasPassword = true,
    this.country,
    this.pinCode,
    this.activePin = false,
    this.deleting = false,
    this.willDeleteAt,
    this.requestDeleteAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
