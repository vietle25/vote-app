import 'dart:io';

import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/fonts.dart';

abstract class CommonStyle {
  /// Main app theme
  static var mainTheme = ThemeData(
    primaryColor: Colors.primary,
    accentColor: Colors.primary,
    platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.red,
    dialogBackgroundColor: Colors.white,
    fontFamily: Fonts.fontNormal,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      brightness: Brightness.dark,
      elevation: 0,
      iconTheme: ThemeData().iconTheme,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Constants.cornerRadius),
        ),
      ),
    ),
  );

  /// Text small
  static TextStyle textSmall({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font12,
    );
  }

  /// Text small bold
  static TextStyle textSmallBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font12,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Text medium
  static TextStyle text({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font14,
    );
  }

  /// Text medium bold
  static TextStyle textBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font14,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Text large
  static TextStyle textMedium({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font16,
      fontWeight: fontWeight,
    );
  }

  /// Text large bold
  static TextStyle textMediumBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font16,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Text x large
  static TextStyle textLarge({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font18,
      fontWeight: fontWeight,
    );
  }

  /// Text x large bold
  static TextStyle textLargeBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font18,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Text xx large
  static TextStyle textXLarge({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font20,
    );
  }

  /// Text xx large bold
  static TextStyle textXLargeBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font20,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Text xx large
  static TextStyle textXXLarge({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font24,
    );
  }

  /// Text xx large bold
  static TextStyle textXXLargeBold({Color? color}) {
    return TextStyle(
      color: color ?? Colors.text,
      fontSize: Fonts.font24,
      fontFamily: Fonts.fontBold,
      fontWeight: FontWeight.w500,
    );
  }

  /// Shadow offset
  static BoxShadow shadowOffset({double? blurRadius}) {
    return BoxShadow(
      color: Colors.shadow,
      spreadRadius: 0,
      blurRadius: blurRadius ?? Constants.elevation,
      offset: Offset(0, 2), // changes position of shadow
    );
  }

  /// Text error
  static const textError = TextStyle(
    fontSize: Fonts.fontSizeSmall,
    color: Colors.red,
  );
}
