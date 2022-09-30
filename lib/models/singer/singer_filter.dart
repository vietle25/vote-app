import 'package:flutter_app/models/common/paging_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'singer_filter.g.dart';

@JsonSerializable()
class SingerFilter {
  int? singerId;
  int? userDeviceId;
  String? deviceId;
  PagingModel? paging;

  SingerFilter({
    this.userDeviceId,
    this.singerId,
    this.deviceId,
    this.paging,
  });

  Map<String, dynamic> toJson() => _$SingerFilterToJson(this);
}
