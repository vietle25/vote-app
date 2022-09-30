import 'package:json_annotation/json_annotation.dart';

part 'login_filter.g.dart';

@JsonSerializable()
class LoginFilter {
  String? email; //Email
  String? password; //Password
  String? phone; //Phone

  LoginFilter({
    this.email,
    this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() => _$LoginFilterToJson(this);
}
