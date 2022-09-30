import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  String? partnerCode;
  String? apiKey;
  int? amount;
  String? currency;
  String? orderId;
  String? bankCode;
  String? paymentMethod;
  String? paymentType;
  String? appotapayTransId;
  int? errorCode;
  String? message;
  int? transactionTs;
  String? extraData;
  String? signature;
  String? paymentUrl;

  PaymentModel({
    this.partnerCode,
    this.apiKey,
    this.amount,
    this.currency,
    this.orderId,
    this.bankCode,
    this.paymentMethod,
    this.paymentType,
    this.appotapayTransId,
    this.errorCode,
    this.message,
    this.transactionTs,
    this.extraData,
    this.signature,
    this.paymentUrl,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
