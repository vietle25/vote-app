import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/images.dart';
import 'package:get/get.dart';

class NoConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.icWifiOffBlue,
          ),
          SizedBox(
            height: Constants.margin24,
          ),
          Text(
            Localizes.opLostConnection.tr,
            style: CommonStyle.textXLargeBold(color: Colors.primary),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Constants.margin8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding24,
            ),
            child: Text(
              Localizes.lostConnectionDes.tr,
              style: CommonStyle.text(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
