import 'package:flutter_app/enums/language.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/user/user_device_model.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:get/get.dart';

/// Save information using in app
class Globals {
  static var user = UserModel().obs; // User info
  static var config = []; // User info
  static var language = Language.english.obs; // Language
  static String token = ''; // Access token api
  static String firstTimeInstall = ''; // Access token api
  static String firebaseToken = ''; // Firebase token
  static String deviceId = ''; // Device id
  static Function onNavigationPush = () => {}; // Push page function
  static Function onNavigationChange = () => {}; // Navigation change
  static var numUnseenNotification = 0.obs; // Number unseen notification
  static var numUncensoredReceipt = 0.obs; // Number unseen notification
  static bool isShowDialogSession = true; // Variable check dialog session
  static double latitude = 0.0; // user's latitude
  static double longitude = 0.0; // user's longitude
  static var connected = true.obs; // check is connect to internet
  static var isRequestingLocation = false.obs;
  static var greeting = Localizes.goodMorning.tr.obs;
  static var showLoading = true.obs;
  static var userDevice = UserDeviceModel();
}
