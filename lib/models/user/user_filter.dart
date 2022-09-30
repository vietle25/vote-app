import 'package:json_annotation/json_annotation.dart';

part 'user_filter.g.dart';

@JsonSerializable()
class UserFilter {
  String? name;
  String? firstName;
  String? phone;
  String? avatar;
  String? address;
  String? email;
  String? password;

  UserFilter({
    this.name,
    this.phone,
    this.avatar,
    this.address,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => _$UserFilterToJson(this);
}
