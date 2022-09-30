import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:get/get.dart';

class DialogWidget extends StatelessWidget {
  final String? titleText; // Title text
  final TextStyle? titleStyle; // Title style
  final String? contentText; // Content text
  final TextStyle? contentStyle; // Content style
  final String? confirmText; // Confirm text
  final String? cancelText; // Cancel text
  final Function? confirmAction; // Confirm action
  final Function? cancelAction; // Cancel action
  final Color? colorButtonOne; // Color button one
  final Color? colorButtonTwo; // Color button two
  final bool showIconClose; // Show icon close
  final bool showOneButton; // Show one button
  final String? icon; // icon
  final Widget? child; // Child

  DialogWidget({
    this.titleText,
    this.titleStyle,
    this.contentText = "",
    this.contentStyle,
    this.cancelText = "",
    this.confirmText = "",
    this.confirmAction,
    this.cancelAction,
    this.colorButtonOne = Colors.grey400,
    this.colorButtonTwo,
    this.showIconClose = false,
    this.showOneButton = false,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(Constants.padding16 * 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.cornerRadius),
      ),
      child: this.child ?? this.renderBody(),
    );
  }

  /// Render body
  Widget renderBody() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          this.icon != null
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                      Constants.margin24,
                      Constants.margin24,
                      Constants.margin24,
                      Constants.margin8),
                  child: Image.asset(this.icon!),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(
              top: Constants.margin16,
              bottom: !showIconClose ? Constants.margin16 : 0,
              // left: Constants.padding16 + Constants.margin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText != null
                    ? Expanded(
                        child: Text(
                          titleText ?? Localizes.notification.tr,
                          style: titleStyle ?? CommonStyle.textXLargeBold(),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: Constants.margin8,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Constants.padding16,
              left: Constants.padding24,
              right: Constants.padding24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    contentText ?? "",
                    style: contentStyle ?? CommonStyle.text(),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Constants.margin12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Constants.margin16,
              ),
              if (!this.showOneButton)
                Expanded(
                  child: ButtonWidget(
                    color: Colors.blue50,
                    titleStyle: CommonStyle.textBold(
                      color: Colors.primary,
                    ),
                    title: cancelText ?? Localizes.cancel.tr,
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    disable: this.showOneButton,
                    onTap: this.onTapClose,
                  ),
                ),
              if (!this.showOneButton)
                SizedBox(
                  width: Constants.margin8,
                ),
              Expanded(
                child: ButtonWidget(
                  color: Colors.primary,
                  titleStyle: CommonStyle.textBold(color: Colors.white),
                  title: confirmText ?? Localizes.ok.tr,
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                  onTap: () {
                    Navigator.of(Get.context!).pop();
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (!Utils.isNull(confirmAction)) confirmAction!();
                  },
                ),
              ),
              SizedBox(
                width: Constants.margin16,
              ),
            ],
          ),
          SizedBox(
            height: Constants.margin16,
          ),
        ],
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
    Navigator.of(Get.context!).pop();
    FocusManager.instance.primaryFocus?.unfocus();
    if (!Utils.isNull(cancelAction)) cancelAction!();
  }
}
