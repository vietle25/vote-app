import 'package:flutter_app/locales/i18n_en.dart';
import 'package:flutter_app/locales/i18n_vi.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'vi': vi,
      };
}
