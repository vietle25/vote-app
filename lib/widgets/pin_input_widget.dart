import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinInputWidget extends StatefulWidget {
  final Function onSubmit;
  final Function onForgot;

  PinInputWidget({
    required this.onSubmit,
    required this.onForgot,
  });

  @override
  State<PinInputWidget> createState() {
    return PinInputWidgetState();
  }
}

class PinInputWidgetState extends State<PinInputWidget> {
  late TextEditingController controller;
  String error = '';
  Color borderColor = Colors.grey50;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.all(Constants.padding16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.cornerRadius),
          topRight: Radius.circular(Constants.cornerRadius),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ButtonWidget(
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                child: Icon(Icons.close_sharp),
                onTap: () {
                  Navigator.of(Get.context!).pop();
                },
              ),
              Expanded(
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: Localizes.enterPIN.tr,
                    style: CommonStyle.textBold(),
                  ),
                ),
              ),
              ButtonWidget(
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                child: Container(),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: Constants.margin24,
          ),
          Container(
            width: Utils.getWidth() - 56,
            padding: EdgeInsets.only(
              top: Constants.padding + 2,
              bottom: Constants.padding - 2,
            ),
            margin: EdgeInsets.symmetric(horizontal: Constants.margin12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                Constants.cornerRadius * 2,
              ),
            ),
            child: PinCodeTextField(
              key: Key("popup"),
              appContext: context,
              autoFocus: true,
              obscureText: true,
              mainAxisAlignment: MainAxisAlignment.center,
              showCursor: false,
              controller: controller,
              cursorColor: Colors.transparent,
              pinTheme: PinTheme(
                activeColor: Colors.transparent,
                selectedColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                borderWidth: 0,
                fieldHeight: 28,
                fieldWidth: 34,
                borderRadius: BorderRadius.circular(Constants.cornerRadius),
                shape: PinCodeFieldShape.box,
              ),
              scrollPadding: EdgeInsets.zero,
              hintCharacter: '●',
              hintStyle: TextStyle(
                  fontSize: 26,
                  color: Colors.grey50,
                  fontWeight: FontWeight.bold,
                  fontFamily: ''),
              backgroundColor: Colors.transparent,
              keyboardType: TextInputType.number,
              length: 6,
              textStyle: TextStyle(
                fontSize: 26,
                color: Colors.primary,
              ),
              animationDuration: Duration.zero,
              onChanged: (input) => {
                setState(() {
                  error = '';
                  borderColor = Colors.grey50;
                }),
              },
              onCompleted: onCompleted,
              autoDismissKeyboard: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: Constants.margin12,
                  horizontal: Constants.margin24,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  error,
                  style: CommonStyle.textSmall(color: Colors.red),
                ),
              ),
              ButtonWidget(
                onTap: () {
                  widget.onForgot();
                },
                color: Colors.transparent,
                title: Localizes.forgotPin.tr,
                titleStyle: CommonStyle.textSmallBold(
                  color: Colors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onCompleted(String value) {
    if (value != Globals.user.value.pinCode) {
      setState(() {
        error = Localizes.pinIncorrect.tr;
        borderColor = Colors.red;
      });
    } else
      widget.onSubmit();
  }
}
