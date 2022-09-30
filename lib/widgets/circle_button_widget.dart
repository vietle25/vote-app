import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

class CircleButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData? icon;
  final Color? iconColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? borderColor;
  final Color? color;
  final bool disable;
  final bool shadow;

  CircleButtonWidget({
    required this.onTap,
    this.color = Colors.pink200,
    this.icon,
    this.margin,
    this.padding,
    this.elevation = 0,
    this.borderColor = Colors.transparent,
    this.disable = false,
    this.shadow = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: !Utils.isNull(margin) ? margin : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.grey200.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(1, 3),
                ),
              ]
            : [],
      ),
      child: Material(
        color: color ?? Colors.pink200,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: disable ? null : onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(
                      vertical: Constants.padding16,
                      horizontal: Constants.padding16),
              child: Icon(
                icon ?? Icons.navigate_next_rounded,
                color: iconColor ?? Colors.primaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
