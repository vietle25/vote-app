import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/enums/enums.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

class ButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget? child;
  final String? title;
  final Widget? icon;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final Color? borderColor;
  final Color? color;
  final bool? transparent;
  final bool disable;
  final bool shadow;
  final bool border;
  final double? width;
  final double? height;
  final ButtonType? type;

  ButtonWidget({
    required this.onTap,
    this.transparent = false,
    this.color = Colors.primary,
    this.child,
    this.title = "",
    this.icon,
    this.margin,
    this.height,
    this.width,
    this.padding,
    this.titleStyle,
    this.elevation = 0,
    this.borderWidth = 0,
    this.borderRadius = Constants.cornerRadius,
    this.borderColor = Colors.transparent,
    this.type,
    this.disable = false,
    this.shadow = false,
    this.border = false,
  });

  // render icon
  Widget renderIcon() {
    return Row(children: [
      icon!,
      Utils.isNull(title) ? SizedBox() : SizedBox(width: Constants.margin12),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: !Utils.isNull(margin) ? margin : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: border ? Border.all(color: Colors.grey100) : null,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.grey400.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(1, 3),
                ),
              ]
            : [],
      ),
      child: Material(
        color: transparent! ? Colors.transparent : color ?? Colors.primary,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: InkWell(
          onTap: disable ? null : onTap,
          customBorder: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor!,
              width: borderWidth!,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
          child: !Utils.isNull(child)
              ? child
              : Padding(
                  padding: padding ??
                      EdgeInsets.symmetric(
                          vertical: Constants.padding12,
                          horizontal: Constants.padding12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Utils.isNull(icon) ? Container() : renderIcon(),
                      Utils.isNull(title)
                          ? Container()
                          : Text(
                              title ?? "",
                              maxLines: 1,
                              style: Utils.isNull(titleStyle)
                                  ? CommonStyle.text()
                                  : titleStyle,
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
