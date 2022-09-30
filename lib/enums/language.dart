import 'package:flutter/material.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/language/language_model.dart';
import 'package:get/get.dart';

/// Language
class Language {
  static const EN = 'en_US';
  static const VI = 'vi_VN';

  /// Convert to locale
  static Locale convertToLocale(String code) {
    switch (code) {
      case VI:
        return Locale(Localizes.viCode);
      case EN:
        return Locale(Localizes.enCode);
      default:
        return Locale(Localizes.enCode);
    }
  }

  static final english = LanguageModel(
    name: Localizes.english.tr,
    code: Locale(Localizes.enCode).languageCode,
    countryCode: EN.split("_")[1].toUpperCase(),
    localesCode: EN,
    flag: "lib/assets/images/flag/us.svg",
  );

  static final vietnamese = LanguageModel(
    name: Localizes.vietnamese.tr,
    code: Locale(Localizes.viCode).languageCode,
    countryCode: VI.split("_")[1].toUpperCase(),
    localesCode: VI,
    flag: "lib/assets/images/flag/vn.svg",
  );
}
