import 'package:flutter_app/values/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paging_model.g.dart';

@JsonSerializable()
class PagingModel {
  int page;
  int pageSize;

  PagingModel({
    this.page: 0,
    this.pageSize: Constants.pageSize,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) =>
      _$PagingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PagingModelToJson(this);
}
