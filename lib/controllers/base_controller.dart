import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_app/configs/error_code.dart';
import 'package:flutter_app/enums/language.dart';
import 'package:flutter_app/enums/notification_type.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/common/config_model.dart';
import 'package:flutter_app/models/common/device_model.dart';
import 'package:flutter_app/models/language/language_model.dart';
import 'package:flutter_app/models/user/user_device_model.dart';
import 'package:flutter_app/models/user/user_model.dart';
import 'package:flutter_app/repositories/common_repository.dart';
import 'package:flutter_app/repositories/notification_repository.dart';
import 'package:flutter_app/repositories/user_repository.dart';
import 'package:flutter_app/utils/storage_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:flutter_app/widgets/bottom_sheet_widget.dart';
import 'package:flutter_app/widgets/dialog_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:platform_device_id/platform_device_id.dart';

class BaseController extends GetxController {
  final chopperLogger = Logger(''); // Chopper logger
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final UserRepository _userRepository = UserRepository.getInstance();
  final CommonRepository _commonRepository = CommonRepository.getInstance();
  final NotificationRepository _notificationRepository =
      NotificationRepository.getInstance();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var bytes = null.obs;
  bool isShowDialogSession = true;

  final ImagePicker imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    // messaging.unsubscribeFromTopic(Constants.topicNotification);
  }

  /// Show dialog confirm
  Future showDialogConfirm(
      {String? title,
      String? content,
      String? confirmText,
      String? cancelText,
      Function? cancelAction,
      Function? confirmAction,
      bool? showOneButton,
      bool barrierDismissible = true,
      bool? showIconClose,
      TextStyle? titleStyle,
      String? icon}) async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: DialogWidget(
          titleText: title,
          contentText: content,
          confirmText: confirmText,
          cancelText: cancelText,
          cancelAction: cancelAction,
          confirmAction: confirmAction,
          showOneButton: showOneButton ?? false,
          showIconClose: showIconClose ?? true,
          titleStyle: titleStyle,
          icon: icon,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  /// Handle net work error
  handleNetWorkError(Object obj) {
    this.closeLoading();
    chopperLogger.info(obj);
    if (obj is SocketException) {
      // OSError osError = obj.osError;
      // handleError(osError.errorCode);
      Utils.isNetWorkConnect().then((internet) => {
            if (internet != null && internet)
              {handleError(ErrorCode.common)}
            else
              {
                this.showMessage(
                  title: Localizes.notification.tr,
                  message: Localizes.connectServerErr.tr,
                )
              }
          });
    } else {
      handleError(ErrorCode.common);
    }
  }

  /// Handle error
  handleError(int? errorCode, {String? message}) {
    switch (errorCode) {
      case ErrorCode.common:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.processingErr.tr,
        );
        break;
      case ErrorCode.authenticateRequired:
        this.showDialogConfirm(
          title: Localizes.notification.tr,
          content: Localizes.authenticateRequire.tr,
          confirmText: Localizes.ok.tr,
          confirmAction: () => this.logout(),
          showOneButton: true,
          barrierDismissible: false,
          showIconClose: false,
        );
        break;
      case ErrorCode.userBanned:
        this.showDialogConfirm(
          title: Localizes.notification.tr,
          content: Localizes.userHasBeenBanned.tr,
          confirmText: Localizes.ok.tr,
          confirmAction: () => this.logout(),
          showOneButton: true,
          barrierDismissible: false,
          showIconClose: false,
        );
        break;
      case ErrorCode.unauthorised:
      case ErrorCode.sessionTimeout:
        if (Globals.isShowDialogSession) {
          Globals.isShowDialogSession = false;
          // this.showDialogConfirm(
          //   title: Localizes.notification.tr,
          //   content: errorCode == ErrorCode.deactivate
          //       ? Localizes.deactivate.tr
          //       : Localizes.sessionTimeout.tr,
          //   confirmText: Localizes.ok.tr,
          //   confirmAction: () {
          //     this.logout();
          //   },
          //   showOneButton: true,
          //   barrierDismissible: false,
          //   showIconClose: false,
          // );
        }
        break;
      case ErrorCode.passwordMismatch:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.passwordNotMatch.tr,
        );
        break;
      case ErrorCode.invalidAccount:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.incorrectAccount.tr,
        );
        break;
      case ErrorCode.accountExisted:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.accountHasBeenRegistered.tr,
        );
        break;
      case ErrorCode.emailExisted:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.emailHasBeenExisted.tr,
        );
        break;
      case ErrorCode.phoneAlreadyLinked:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.phoneHasBeenExisted.tr,
        );
        break;
      default:
        this.showMessage(
          title: Localizes.notification.tr,
          message: Localizes.processingErr.tr,
        );
        break;
    }
  }

  handleConfirm({Function? onConfirm, String? content}) {
    showDialogConfirm(
      content: content ?? Localizes.confirmNote.tr,
      confirmText: Localizes.ok.tr,
      confirmAction: onConfirm ?? () => this.goBack(),
      cancelAction: () => this.navigatorPopOverlay(),
      barrierDismissible: true,
      showIconClose: false,
    );
  }

  /// Navigate to new screen with name.
  Future goTo(String router, [dynamic params]) async {
    this.navigatorPopOverlay();
    await Get.toNamed(router, arguments: params);
  }

  /// Navigate to new screen with name and get data go back
  Future goToAndGetResult(String router, [dynamic params]) async {
    this.navigatorPopOverlay();
    return await Get.toNamed(router, arguments: params);
  }

  /// Navigate to new screen with name and bottom bar
  Future goToWithBottomBar(BuildContext context, String routerName) async {
    // await Get.toNamed(router, arguments: params);
    Globals.onNavigationPush(context, routerName);
  }

  /// Navigate and remove the previous screen from the tree.
  Future goToAndRemove(String router, [dynamic params]) async =>
      await Get.offNamed(router, arguments: params);

  /// Navigate and remove all previous screens from the tree.
  Future goToAndRemoveAll(String router, [dynamic params]) async =>
      await Get.offAllNamed(router, arguments: params);

  /// Go back
  Future goBack({BuildContext? context, result}) async {
    this.navigatorPopOverlay();
    if (!Utils.isNull(context)) {
      Navigator.pop(context!);
    } else {
      Get.back(result: result);
    }
  }

  /// Handle back
  Future<bool> handleBack() async {
    if (EasyLoading.isShow) {
      this.closeLoading();
    }
    return true;
  }

  /// Show dialog loading
  void showLoading() => EasyLoading.show();

  /// Close dialog loading
  void closeLoading() => EasyLoading.dismiss();

  /// Close snack bars, dialogs, bottom sheets, or anything you would normally
  void navigatorPopOverlay() {
    if (Get.isOverlaysOpen) Navigator.pop(Get.overlayContext!);
  }

  /// Show message
  showMessage({String? title, String? message}) {
    // if (!Get.isOverlaysOpen)
    if (true)
      Get.snackbar(
        title ?? Localizes.notification.tr,
        message!,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(Constants.margin16),
        backgroundColor: Colors.background.withOpacity(0.4),
      );
  }

  /// Handle message push
  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotification =
        new FlutterLocalNotificationsPlugin();
    var initializationAndroid =
        new AndroidInitializationSettings('@mipmap/ic_notification');
    // var initializationIOS = IOSInitializationSettings();
    // var initializationSettings = new InitializationSettings(
    //     android: initializationAndroid, iOS: initializationIOS);
    // flutterLocalNotification.initialize(initializationSettings);
    //
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //     'chanelId', 'channelName', 'channel description',
    //     importance: Importance.max,
    //     playSound: true,
    //     showProgress: true,
    //     priority: Priority.high,
    //     ticker: 'test ticker');

    // var iOSChannelSpecifics = IOSNotificationDetails();
    // var platformChannelSpecifics = NotificationDetails(
    //     android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    // await flutterLocalNotification.show(
    //   0,
    //   message['data']['title'],
    //   message['data']['body'],
    //   platformChannelSpecifics,
    //   payload: message['data'].toString(),
    // );
    return Future<void>.value();
  }

  /// Show notification
  void showNotification({String? title, String? body, String? data}) async {
    await _localNotification(title!, body!, data ?? "");
  }

  Future<void> _localNotification(
      String title, String body, String? data) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'chanelId', 'channelName',
        importance: Importance.max,
        icon: "app_logo",
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  /// On iOS, macOS & web, before FCM payloads can be received on your device, you must first ask the user's permission.
  /// Android applications are not required to request permission.
  requestNotifyPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized)
      handleNotification();

    print('User granted permission: ${settings.authorizationStatus}');
  }

  /// Init handle notification
  handleNotification() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      try {
        if (message.data != null) {
          String title = message.data['title_vi'];
          String body = message.data['content_vi'];
          if (Globals.language.value.localesCode == Language.EN &&
              !Utils.isNull(message.data['title_en'])) {
            title = message.data['title_en'];
            body = message.data['content_en'];
          }
          showNotification(title: title, body: body);
          this.countUnseenNotification();
        }
        print("onMessage: $message");
      } on Exception catch (exception) {
        print(exception);
      }
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    messaging.subscribeToTopic(Constants.topicNotification);
  }

  // Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   print('Got a message whilst in the bckground!');
  //   print('Message data: ${message.data}');
  //   try {
  //     if (message.data['type'] ==
  //         NotificationType.approved_receipt.toString()) {
  //       bool registeredDetail = Get.isRegistered<ReceiptDetailController>();
  //       if (registeredDetail) {
  //         ReceiptDetailController controller =
  //             Get.find<ReceiptDetailController>();
  //         if (controller.initialized) {
  //           controller.onRefresh();
  //           controller.showDialogCensoredSuccess(
  //             receiptCode: message.data['receiptCode'],
  //             price: double.parse(message.data['receiptPrice']),
  //             receiptCurrency: message.data['receiptCurrency'],
  //           );
  //         }
  //       } else {
  //         bool registered = Get.isRegistered<ReceiptListController>();
  //         if (registered) {
  //           ReceiptListController controller =
  //               Get.find<ReceiptListController>();
  //           if (controller.initialized) {
  //             controller.onRefresh();
  //             controller.showDialogCensoredSuccess(
  //               receiptCode: message.data['receiptCode'],
  //               price: double.parse(message.data['receiptPrice']),
  //               receiptCurrency: message.data['receiptCurrency'],
  //             );
  //           }
  //         }
  //       }
  //     } else {
  //       String title = message.data['title_vi'];
  //       String body = message.data['content_vi'];
  //       if (Globals.language.value.localesCode == Language.EN &&
  //           !Utils.isNull(message.data['title_en'])) {
  //         title = message.data['title_en'];
  //         body = message.data['content_en'];
  //       }
  //       showNotification(title: title, body: body);
  //       this.countUnseenNotification();
  //     }
  //
  //     print("onMessage: $message");
  //   } on Exception catch (exception) {
  //     print(exception);
  //   }
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // }

  /// on press notification
  void selectNotification(String? payload) async {
    Map<String, dynamic> data = jsonDecode(payload ?? "");
    if (!Utils.isNull(data)) {
      switch (data['type']) {
        case NotificationType.message_notification:
          break;
        default:
      }
    } else {}
  }

  // Future<XFile> retrieveLostData() async {
  //   final LostDataResponse response = await imagePicker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.files != null) {
  //     for (final XFile file in response.files ?? []) {
  //       return file;
  //     }
  //   } else if (response.file != null) {
  //     for (final XFile file in response?.files) {
  //       return file;
  //     }
  //   } else {
  //     print("Error retrieve lost data " + response.exception!.code.toString());
  //   }
  // }

  ///get image from camera or gallery
  Future<dynamic> getImage({gallery: false, cropper: false}) async {
    final picker = ImagePicker();
    this.navigatorPopOverlay();
    XFile? image = await picker.pickImage(
      source: gallery ? ImageSource.gallery : ImageSource.camera,
      // maxHeight: Utils.getHeight(),
      // maxWidth: Utils.getWidth(),
      imageQuality: 50,
    );
    this.navigatorPopOverlay();
    if (image != null) {
      if (cropper) {
        var imageCropper = await cropImage(image);
        if (!Utils.isNull(imageCropper)) {
          return imageCropper;
        }
      } else {
        return image;
      }
    }
    return "";
  }

  ///crop image
  Future<File?> cropImage(imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      return croppedFile;
    }
    return null;
  }

  /// Get device token
  Future<String?> getDeviceToken() async {
    try {
      String? deviceId = await PlatformDeviceId.getDeviceId;
      Globals.deviceId = deviceId!;
      await StorageUtil.storeItem(StorageUtil.deviceId, deviceId);
      return deviceId;
    } on PlatformException {
      print('Failed to get platform version');
    } on MissingPluginException {
      print('Get device token error');
    }
    return null;
  }

  /// Get token firebase
  Future<String?> getFirebaseToken() async {
    var token = await messaging.getToken();
    Globals.firebaseToken = token ?? "";
    await StorageUtil.storeItem(StorageUtil.deviceId, token);
    return token;
  }

  void saveUserDevice() async {
    String? token = await getDeviceToken();
    String? firebaseToken = await getFirebaseToken();
    DeviceModel model = DeviceModel(
      deviceId: token ?? "",
      deviceToken: firebaseToken,
    );
    _userRepository.saveUserDevice(model);
  }

  Future<void> deleteUserDevice() async {
    String? token = await getDeviceToken();
    UserDeviceModel model = UserDeviceModel(
      deviceId: token,
    );
    _userRepository.deleteUserDevice(model);
  }

  /// Log out
  Future<void> logout() async {
    this.showLoading();
    await deleteUserDevice();
    await StorageUtil.deleteItem(StorageUtil.userProfile);
    await StorageUtil.deleteItem(StorageUtil.firebaseToken);
    await StorageUtil.deleteItem(StorageUtil.deviceToken);
    await StorageUtil.deleteItem(StorageUtil.shoppingCart);
    FacebookAuth.instance.logOut();
    GoogleSignIn().signOut();
    Globals.user.value = UserModel();
    Globals.firebaseToken = '';
    Globals.token = '';
    FirebaseAuth.instance.signOut();
    this.closeLoading();
    Future.delayed(Duration(milliseconds: 2000), () {
      this.isShowDialogSession = true;
    });
  }

  /// Close keyboard
  void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  /// Show bottom sheet
  Future showBottomSheet(
      {required String title,
      required Widget child,
      double? height,
      bool showIconClose = false,
      String? subTitle,
      bool? iconCloseRight,
      bool? expandChild,
      Function? onDismiss,
      bool isScrollControlled = true}) async {
    await Get.bottomSheet(
      BottomSheetWidget(
          height: height,
          title: title,
          subTitle: subTitle,
          child: child,
          iconCloseRight: iconCloseRight,
          expandChild: false,
          onDismiss: onDismiss,
          showIconClose: showIconClose),
      isScrollControlled: isScrollControlled,
    );
  }

  /// Show date
  Future<DateTime?> showDate(
    DateTime selectedDate, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: firstDate ?? DateTime(1945),
      lastDate: lastDate ?? DateTime(2101),
      locale: Language.convertToLocale(Globals.language.value.localesCode),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.primary,
            colorScheme: ColorScheme.light(primary: Colors.primary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      return picked;
    }
    return null;
  }

  /// Show time
  Future<TimeOfDay> showTime(TimeOfDay selected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selected,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.primary,
            colorScheme: ColorScheme.light(primary: Colors.primary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      return picked;
    }
    return TimeOfDay.now();
  }

  Future<void> getProfile() async {
    await _userRepository.getProfile().then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data)) {
          UserModel user = new UserModel.fromJson(data);
          Globals.user.value = user;
          Globals.user.refresh();
          StorageUtil.storeItem(StorageUtil.userProfile, data);
        } else {
          var errorCode = res.body!.errorCode;
          handleError(errorCode);
        }
      } else {
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }

  Future<void> getConfig() async {
    await _commonRepository.getConfig().then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data) && data is List) {
          var list = [];
          data.forEach((el) => list.add(ConfigModel.fromJson(el)));
          Globals.config = list;
          StorageUtil.storeItem(StorageUtil.config, list);
        }
      } else {
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }

  Future<void> countUnseenNotification() async {
    await _notificationRepository.countUnSeenNotification().then((res) async {
      if (res.isSuccessful) {
        var data = res.body!.data;
        if (!Utils.isNull(data)) {
          Globals.numUnseenNotification.value = data;
        } else
          Globals.numUnseenNotification.value = 0;
      } else {
        Globals.numUnseenNotification.value = 0;
        var errorCode = res.body!.errorCode;
        handleError(errorCode);
      }
    }).catchError((Object obj) {
      handleNetWorkError(obj);
    });
  }

  changeLanguage({required LanguageModel lang}) async {
    Globals.language.value = lang;
    await StorageUtil.storeItem(StorageUtil.language, lang);
    List<String> values = lang.localesCode.split('_');
    if (values.length > 1) {
      Get.updateLocale(Locale(values[0], values[1]));
      this.navigatorPopOverlay();
    }
  }
}
