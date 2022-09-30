import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final String userProfile = 'userProfile';
  static final String config = 'config';
  static final String language = 'language'; // Save language
  static final String deviceToken = 'deviceToken'; // Access token api
  static final String userDevice = 'userDevice'; // Access token api
  static final String deviceId = 'deviceId'; // Device id
  static final String firebaseToken = 'firebaseToken'; // Firebase token
  static final String shoppingCart = 'shoppingCart'; // shopping cart
  static final String branch = 'branch'; // shopping cart
  static final String firstTimeInstallApp =
      'firstTimeInstallApp'; // first time install app
  static final String voucher = "voucher";

  /// Store item
  static Future<void> storeItem(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json.encode(value));
  }

  /// Delete item
  static Future<void> deleteItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// Retrieve item
  static Future<dynamic> retrieveItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    if (value != null) {
      return jsonDecode(value);
    }
    return null;
  }

  /// Delete all
  static Future<void> deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
