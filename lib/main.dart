import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/enums/language.dart';
import 'package:flutter_app/router/app_route.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import 'enums/notification_type.dart';
import 'firebase_options.dart';
import 'locales/app_translations.dart';
import 'locales/localizes.dart';
import 'styles/common_style.dart';
import 'utils/utils.dart';
import 'values/colors.dart';
import 'values/globals.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message}");
  try {
    if (message.data['type'] == NotificationType.approved_receipt.toString()) {
    } else {
      String title = message.data['title_vi'];
      String body = message.data['content_vi'];
      if (Globals.language.value.localesCode == Language.EN &&
          !Utils.isNull(message.data['title_en'])) {
        title = message.data['title_en'];
        body = message.data['content_en'];
      }

      showNotification(title: title, body: body);
    }

    print("onMessage: $message");
  } on Exception catch (exception) {
    print(exception);
  }

  print("Handling a background message: ${message.messageId}");
}

void showNotification({String? title, String? body, String? data}) async {
  await _localNotification(title!, body!, data ?? "");
}

Future<void> _localNotification(String title, String body, String? data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_notification');

  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FlutterDownloader.initialize(debug: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupLogging();
  await checkStatusLogin();
  await Utils.getLocaleLanguageApp();
  runApp(MyApp());
  configLoading();
  // LocationService.determinePosition();
}

/// Check status login
Future<void> checkStatusLogin() async {
  // dynamic token = await StorageUtil.retrieveItem(StorageUtil.token);
  // var user = await StorageUtil.retrieveItem(StorageUtil.userProfile);
  // var firstTimeInstall =
  //     await StorageUtil.retrieveItem(StorageUtil.firstTimeInstallApp);
  // Globals.firstTimeInstall = firstTimeInstall ?? "";
  // if (!Utils.isNull(user) && !Utils.isNull(token)) {
  //   Globals.user.value = UserModel.fromJson(user);
  //   Globals.token = token;
  // }
}

/// Setup log
void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

/// Config loading
void configLoading() => EasyLoading.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = EasyLoadingIndicatorType.ring
  ..loadingStyle = EasyLoadingStyle.custom
  ..indicatorSize = 40.0
  ..radius = 10.0
  ..progressColor = Colors.primary
  ..backgroundColor = Colors.transparent
  ..indicatorColor = Colors.primary
  ..textColor = Colors.primary
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = false
  ..dismissOnTap = false;

class MyApp extends StatelessWidget {
  getInitialRoute() {
    return AppRoute.ROUTE_HOME;
  }

  loggingScreen(Routing routing) async {
    String current = routing.current;
    await FirebaseAnalytics.instance.logEvent(
      name: "screen_view",
      parameters: {
        'firebase_screen': current,
        'firebase_screen_class': current,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vote',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200),
      getPages: AppRoute.route,
      initialRoute: getInitialRoute(),
      translations: AppTranslations(),
      theme: CommonStyle.mainTheme,
      builder: EasyLoading.init(),
      routingCallback: (routing) {
        loggingScreen(routing!);
        if (routing.current == AppRoute.ROUTE_HOME) {}
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale(Localizes.enCode, ''),
        const Locale(Localizes.viCode, '')
      ],
    );
  }
}
