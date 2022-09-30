import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_app/controllers/home_controller.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/images.dart';
import 'package:flutter_app/views/base/base_view.dart';
import 'package:flutter_app/views/home/item_member.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:get/get.dart';

class HomeView extends BaseView {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  /// Render app bar
  PreferredSizeWidget? renderAppBar({AppBarModel? appBarModel}) {
    return AppBar(
      leading: ButtonWidget(
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(left: 16),
        onTap: () {},
        child: Image.asset(
          Images.icLogoSplash,
        ),
      ),
      leadingWidth: 72,
      elevation: 2,
      shadowColor: Colors.white,
      actions: [
        ButtonWidget(
          color: Colors.transparent,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.symmetric(horizontal: 16),
          onTap: () {},
          child: Image.asset(
            Images.icRankBlack,
            width: 24,
            height: 24,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget renderBody({BuildContext? context}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraint) {
        return RefreshIndicator(
          onRefresh: _homeController.handlerRefresh,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.margin16,
              vertical: Constants.margin12,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: Constants.margin12,
                  ),
                  child: Text(
                    "Danh sách thí sinh",
                    style: CommonStyle.textMediumBold(),
                  ),
                ),
                Flexible(
                  child: Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 12,
                      childAspectRatio: 9 / 12,
                      children: _homeController.data
                          .map((item) => ItemMember(item: item))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
