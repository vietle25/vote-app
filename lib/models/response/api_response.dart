import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  @JsonKey(name: 'error')
  dynamic error; //Error
  @JsonKey(name: 'errorCode')
  int? errorCode; //Error code
  @JsonKey(name: 'data')
  dynamic data;

  ApiResponse({this.data});
  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
