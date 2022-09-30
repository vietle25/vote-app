import 'package:flutter_app/locales/localizes.dart';
import 'package:get/get.dart';

class DocumentType {
  static const idCard = 0;
  static const passport = 1;
  static const driverLicense = 2;

  static Map<dynamic, dynamic> getMap(){
    return {
      Localizes.idCard.tr: idCard,
      Localizes.passport.tr: passport,
      Localizes.driverLicense.tr: driverLicense,
    };
  }

  static String getStringValue(int? type) {
    switch (type) {
      case idCard:
        return Localizes.idCard.tr;
      case passport:
        return Localizes.passport.tr;
      case driverLicense:
        return Localizes.driverLicense.tr;
      default:
        return Localizes.idCard.tr;
    }
  }
}
