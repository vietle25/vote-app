import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

class CardWidget extends StatelessWidget {
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final VoidCallback? onTap;

  CardWidget(
      {this.color = Colors.white,
      this.margin = const EdgeInsets.symmetric(horizontal: Constants.margin16),
      this.padding = const EdgeInsets.symmetric(
        horizontal: Constants.padding16,
        vertical: Constants.padding12,
      ),
      required this.child,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(Constants.cornerRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Constants.cornerRadius),
          child: child,
        ),
      ),
    );
  }
}
