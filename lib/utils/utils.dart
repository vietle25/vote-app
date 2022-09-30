import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/language.dart';
import 'package:flutter_app/models/language/language_model.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import 'storage_util.dart';

class Utils {
  /// Get width screen
  static double getWidth() => Get.width;

  /// Get height screen
  static double getHeight() => Get.height;

  /// Get status bar height
  static double getStatusBarHeight() => MediaQuery.of(Get.context!).padding.top;

  /// Get height screen no status bar
  static double getHeightWindow() =>
      Get.height -
      MediaQuery.of(Get.context!).viewPadding.top;

  /// Get height screen no app bar
  static double getHeightNoAppBar() =>
      Get.height - MediaQuery.of(Get.context!).padding.top - kToolbarHeight;

  /// Get width screen percent
  static double getWidthPercent(double percent) => (getWidth() * percent) / 100;

  /// Get height screen percent
  static double getHeightPercent(double percent) =>
      (getHeight() * percent) / 100;

  /// Checks if data is null.
  static bool isNull(dynamic data) {
    if (data is String &&
        (data.isEmpty || (data.isNotEmpty && data.trim() == ""))) {
      return true;
    }
    return GetUtils.isNull(data);
  }

  /// Check have network connect
  static Future<bool> isNetWorkConnect() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  /// Get language app
  static Future<void> getLocaleLanguageApp() async {
    var data = await StorageUtil.retrieveItem(StorageUtil.language);
    if (!Utils.isNull(data)) {
      // Globals.language = data as String;
      Globals.language.value = LanguageModel.fromJson(data);
    } else {
      Globals.language.value = Language.english;
    }
    // List<String> values = Globals.language.value.code.split('_');
    // if (values.length > 1) {
    return Get.updateLocale(Locale(
        Globals.language.value.code, Globals.language.value.countryCode));
    // }
  }

  static getHeaderRequest() {
    Map<String, String> headers = Map<String, String>();
    String username = 'kinderworld-staging-mobile-api';
    String password = 'O91997QcA1wy6j9R';
    return headers;
  }

  static vibrate() async {
    bool? hasVibrate = await Vibration.hasVibrator() ?? false;
    if (hasVibrate) {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(duration: 200);
      } else {
        Vibration.vibrate();
      }
    }
  }
}
