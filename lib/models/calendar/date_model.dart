import 'package:json_annotation/json_annotation.dart';

part 'date_model.g.dart';

@JsonSerializable()
class DateModel {
  int? id;
  int date;
  int month;
  int year;
  String dayOfWeek;
  DateTime dateTime;
  String? title;
  dynamic icon;
  dynamic color;

  DateModel({
    this.id,
    required this.date,
    required this.month,
    required this.year,
    required this.dayOfWeek,
    required this.dateTime,
    this.title,
    this.icon,
    this.color,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) =>
      _$DateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DateModelToJson(this);
}
