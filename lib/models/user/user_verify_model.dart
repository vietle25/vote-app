import 'package:json_annotation/json_annotation.dart';

part 'user_verify_model.g.dart';

@JsonSerializable()
class UserVerifyModel {
  String? firstVerifyImage;
  String? secondVerifyImage;
  int? documentType;
  String? countryCode;
  String? legalName;
  String? documentId;
  int? verificationStatus;
  String? reasonRejected;
  String? dob;
  String? frontDocument;
  String? backDocument;

  UserVerifyModel({
    this.firstVerifyImage,
    this.secondVerifyImage,
    this.documentType,
    this.countryCode,
    this.documentId,
    this.legalName,
    this.verificationStatus,
    this.reasonRejected,
    this.dob,
    this.frontDocument,
    this.backDocument,
  });

  Map<String, dynamic> toJson() => _$UserVerifyModelToJson(this);

  factory UserVerifyModel.fromJson(Map<String, dynamic> json) =>
      _$UserVerifyModelFromJson(json);
}
