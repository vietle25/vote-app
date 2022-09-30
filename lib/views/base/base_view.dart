import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/controllers/base_controller.dart';
import 'package:flutter_app/models/common/app_bar_model.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/images.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:get/get.dart';

class BaseView extends StatelessWidget {
  final BaseController _baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.background,
      appBar: this.renderAppBar(),
      body: this.renderBody(context: context),
    );
  }

  /// Go back
  Future goBack({BuildContext? context}) async {
    _baseController.goBack(context: context);
  }

  /// Render app bar
  PreferredSizeWidget? renderAppBar({AppBarModel? appBarModel}) {
    return AppBar(
      leading: appBarModel != null && appBarModel.isBack
          ? ButtonWidget(
              transparent: true,
              icon: appBarModel.iconBack != null
                  ? appBarModel.iconBack
                  : Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.primary,
                    ),
              onTap: () => appBarModel.onBack != null
                  ? appBarModel.onBack!()
                  : this.goBack(),
            )
          : Container(),
      centerTitle: appBarModel?.centerTitle,
      elevation: appBarModel != null && appBarModel.shadow ? 2 : 0,
      shadowColor: Colors.white,
      title: Text(
        (appBarModel != null && appBarModel.title != null
            ? appBarModel.title
            : "Welcome")!,
        style: CommonStyle.textLargeBold(
          color: appBarModel!.isBackground ? Colors.white : Colors.text,
        ),
      ),
      titleSpacing: 16,
      actions: appBarModel.actions,
      backgroundColor: Colors.white,
      brightness: Brightness.dark,
      automaticallyImplyLeading: true,
      flexibleSpace: appBarModel.isBackground
          ? Image(
              image: AssetImage(Images.bgLogin),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : null,
    );
  }

  /// Render body
  Widget? renderBody({BuildContext? context}) {
    return null;
  }
}
