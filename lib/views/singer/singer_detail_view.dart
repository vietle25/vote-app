import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:get/get.dart';

class SingerDetailView extends BaseView {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  /// Render app bar
  PreferredSizeWidget? renderAppBar({AppBarModel? appBarModel}) {
    return null;
  }

  @override
  Widget renderBody({BuildContext? context}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraint.maxHeight,
          ),
          child: RefreshIndicator(
            onRefresh: _homeController.handlerRefresh,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.margin16,
                  vertical: Constants.margin12,
                ),
                color: Colors.white,
                child: Stack(
                  children: [],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
