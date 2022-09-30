import 'package:json_annotation/json_annotation.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  int? id;
  String? name;
  String? code;
  int? type;
  String? date;
  String? cvv;
  String? content;
  String? icon;

  PaymentMethodModel({
    this.id,
    this.name,
    this.code,
    this.type,
    this.content,
    this.icon,
    this.date,
    this.cvv,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}
