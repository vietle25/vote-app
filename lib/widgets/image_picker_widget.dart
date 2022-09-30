import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/dialog_widget.dart';
import 'package:get/get.dart';

class ImagePickerWidget extends StatelessWidget {
  final GestureTapCallback clickCamera;
  final GestureTapCallback clickGallery;
  final String? title;

  ImagePickerWidget({
    Key? key,
    required this.clickCamera,
    required this.clickGallery,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DialogWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Constants.margin12,
            ),
            child: Text(
              title ?? Localizes.avatarProfile.tr,
              style: CommonStyle.textLargeBold(),
              textAlign: TextAlign.center,
            ),
          ),
          renderItemButton(
            title: Localizes.clickCamera.tr,
            icon: Icon(
              Icons.camera_alt_outlined,
              color: Colors.primary,
            ),
            onTap: clickCamera,
          ),
          renderItemButton(
            title: Localizes.clickGallery.tr,
            icon: Icon(
              Icons.photo_library_outlined,
              color: Colors.primary,
            ),
            onTap: clickGallery,
          ),
        ],
      ),
    );
  }

  Widget renderItemButton({
    Widget? icon,
    String? title,
    required GestureTapCallback onTap,
    Color? color,
  }) {
    return ButtonWidget(
      width: Utils.getWidth(),
      color: color ?? Colors.white,
      child: Container(
        padding: EdgeInsets.all(Constants.padding16),
        child: Row(
          children: [
            icon ?? Container(),
            SizedBox(
              width: icon != null ? Constants.padding16 : 0,
            ),
            Text(
              title ?? "",
              maxLines: 1,
              style: CommonStyle.text(),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
