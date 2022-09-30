import 'package:flutter_app/locales/localizes.dart';
import 'package:get/get.dart';

class PolicyType {
  static String terms = "terms.and.conditions";
  static String guide = "guide_user";
  static String privacy = "privacy_policy";
  static String payment = "payment_policy";
  // "termsAndConditions": "terms.and.conditions.en",
  // "guideUser": "guide_user.en",
  // "paymentPolicy": "payment_policy.en",
  // "privacyPolicy": "privacy_policy.en",

  static List<String> getList() {
    return [privacy, terms, guide, payment];
  }

  static String checkLanguage(String title) {
    return title + "." + Localizes.languageCode.tr;
  }

  static bool checkValue(String? type) {
    if (type == checkLanguage(terms)) {
      return true;
    } else if (type == checkLanguage(guide)) {
      return true;
    } else if (type == checkLanguage(privacy)) {
      return true;
    } else if (type == checkLanguage(payment)) {
      return true;
    } else {
      return false;
    }
  }

  static String getStringValue(String? type) {
    if (type == checkLanguage(terms)) {
      return Localizes.termsAndConditionsTitle.tr;
    } else if (type == checkLanguage(guide)) {
      return Localizes.guideUserTitle.tr;
    } else if (type == checkLanguage(privacy)) {
      return Localizes.privacyPolicyTitle.tr;
    } else if (type == checkLanguage(payment)) {
      return Localizes.paymentPolicyTitle.tr;
    } else {
      return Localizes.termsAndConditionsTitle.tr;
    }
  }
}
