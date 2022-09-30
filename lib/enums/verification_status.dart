import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:get/get.dart';

class VerificationStatus {
  static const rejected = -1;
  static const pending = 0;
  static const approved = 1;
  static const notVerify = 2;

  static String getStringValue(int? type) {
    switch (type) {
      case rejected:
        return Localizes.rejectedAccount.tr;
      case pending:
        return Localizes.validatingAccount.tr;
      case approved:
        return Localizes.verifiedAccount.tr;
      case notVerify:
        return Localizes.unverifiedAccount.tr;
      default:
        return Localizes.unverifiedAccount.tr;
    }
  }

  static Color getColorValue(int? type) {
    switch (type) {
      case rejected:
        return Colors.orange500;
      case pending:
        return Colors.grey400;
      case approved:
        return Colors.green;
      case notVerify:
        return Colors.grey50;
      default:
        return Colors.grey50;
    }
  }

  static Color getColorTitleValue(int? type) {
    if (type == notVerify || type == null) {
      return Colors.text;
    } else {
      return Colors.white;
    }
  }
}
