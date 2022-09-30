import 'package:flutter_app/models/common/paging_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_filter.g.dart';

@JsonSerializable()
class CommonFilter {
  String? searchText;
  PagingModel? paging;
  String? isoCode;
  int? id;

  CommonFilter({
    this.searchText,
    this.paging,
    this.isoCode,
    this.id,
  });

  Map<String, dynamic> toJson() => _$CommonFilterToJson(this);
}
