import 'package:json_annotation/json_annotation.dart';

part 'otp_filter.g.dart';

@JsonSerializable()
class OtpFilter {
  String? phone;
  String? phoneCode;
  int? userId;

  OtpFilter({
    this.phoneCode,
    this.phone,
    this.userId,
  });

  Map<String, dynamic> toJson() => _$OtpFilterToJson(this);
}
