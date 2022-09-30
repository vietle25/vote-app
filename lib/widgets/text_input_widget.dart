import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/widgets/text_field_widget.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final Color? color;
  final Color? bgColor;
  final Color? borderColor;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onTapSuffix;
  final Function? onTapPrefix;
  final String hintText;
  final TextStyle? titleStyle;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onFieldSubmitted;
  final bool disable;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  TextInputWidget({
    required this.controller,
    this.color = Colors.primary,
    this.title = "",
    this.suffixIcon,
    this.onTapSuffix,
    this.titleStyle,
    required this.hintText,
    this.obscureText = false,
    this.autofocus = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.prefixIcon,
    this.inputFormatters,
    this.onTapPrefix,
    this.prefixWidget,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.disable = false,
    this.bgColor,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Utils.isNull(this.title)
              ? Container()
              : Text(
                  this.title!,
                  style: titleStyle ??
                      CommonStyle.textSmallBold(color: Colors.grey400),
                ),
          SizedBox(
            height: Utils.isNull(this.title) ? 0 : Constants.margin8,
          ),
          TextFieldWidget(
            controller: controller,
            keyboardType: keyboardType,
            hintText: hintText,
            margin: EdgeInsets.zero,
            style: CommonStyle.text(),
            containerDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.cornerRadius),
              color: bgColor ?? Colors.white,
              border: Border.all(
                color: borderColor ?? Colors.grey100,
                style: BorderStyle.solid,
                width: Constants.borderWidth,
              ),
            ),
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            suffixIcon: suffixIcon,
            onTapSuffix: onTapSuffix,
            obscureText: obscureText,
            textInputAction: textInputAction,
            onChanged: onChanged,
            validator: validator,
            inputFormatters: inputFormatters,
            prefixIcon: prefixIcon,
            onTapPrefix: onTapPrefix,
            prefixWidget: prefixWidget,
            textAlign: textAlign,
            textCapitalization: textCapitalization,
            onFieldSubmitted: onFieldSubmitted,
            autofocus: autofocus,
            enabled: !disable,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
