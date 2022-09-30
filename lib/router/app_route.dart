import 'package:flutter_app/views/home/home_view.dart';
import 'package:flutter_app/views/splash/splash_view.dart';
import 'package:get/get.dart';

class AppRoute {
  static const ROUTE_SPLASH = '/';
  static const ROUTE_HOME = '/home';

  static final route = [
    GetPage(
      name: ROUTE_SPLASH,
      page: () => SplashView(),
    ),
    GetPage(
      name: ROUTE_HOME,
      page: () => HomeView(),
    ),
  ];
}
