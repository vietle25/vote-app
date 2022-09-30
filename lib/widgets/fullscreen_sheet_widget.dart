import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:get/get.dart';

class FullScreenSheetWidget extends StatelessWidget {
  final String? title; // Title text
  final String? subTitle; // Title text
  final TextStyle? titleStyle; // Title style
  final bool showIconClose; // Show icon close
  final Widget? child; // Child
  final double? height;

  FullScreenSheetWidget({
    this.title,
    this.subTitle,
    this.titleStyle,
    this.showIconClose = false,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return this.renderBody();
  }

  /// Render body
  Widget renderBody() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Builder(
        builder: (context) => Container(
          height: this.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.cornerRadius),
              topRight: Radius.circular(Constants.cornerRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  Constants.padding16,
                  0,
                  Constants.padding16,
                  Constants.padding16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? Localizes.notification.tr,
                          style: titleStyle ??
                              CommonStyle.textXLargeBold(color: Colors.primary),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: Constants.margin,
                        ),
                        Utils.isNull(subTitle)
                            ? Container()
                            : Text(
                                subTitle!,
                                style: CommonStyle.text(),
                                textAlign: TextAlign.left,
                              ),
                      ],
                    ),
                    renderCloseButton(),
                  ],
                ),
              ),
              Flexible(flex: 1, child: this.child ?? Container()),
            ],
          ),
        ),
      ),
    );
  }

  // Returns the close button on the top right
  Widget renderCloseButton() {
    return showIconClose
        ? ButtonWidget(
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            child: Icon(Icons.close),
            onTap: this.onTapClose,
          )
        : Container();
  }

  /// On tap close
  onTapClose() {
    Navigator.of(Get.context!, rootNavigator: true).pop();
  }
}
