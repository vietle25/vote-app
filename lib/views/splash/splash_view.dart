import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/router/app_route.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/images.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:get/get.dart';

class SplashView extends BaseView {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  /// Render app bar
  @override
  PreferredSizeWidget? renderAppBar({AppBarModel? appBarModel}) {
    return null;
  }

  getInitialRoute() async {
    await Future.delayed(
      Duration(seconds: 2),
      () async {
        await Get.toNamed(AppRoute.ROUTE_HOME);
      },
    );
  }

  /// Render body login
  @override
  Widget renderBody({BuildContext? context}) {
    // getInitialRoute();
    return Container(
      height: Utils.getHeight(),
      width: Utils.getWidth(),
      color: Colors.white,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        fit: StackFit.expand,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(Images.icLogo),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Utils.getWidth(),
              child: Image.asset(
                Images.imageSplash,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
