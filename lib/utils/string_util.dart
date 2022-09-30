import 'dart:math';

import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StringUtil {
  static RegExp passwordRegex =
      RegExp(r'^([\w!_`()+-=$#&@~](?!\.)(?!\:)(?!\;)(?!\,)){8}$');
  static RegExp rangePasswordRegex = RegExp(r'^.{6,64}$');

  // static RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  // static RegExp emailRegex =
  //     RegExp(r"^[a-zA-Z0-9]+(?:\.[0-9A-Za-z])*@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+");
  static RegExp emailRegex =
      RegExp(r"^[a-zA-Z0-9]+(?:\.[0-9A-Za-z]+)*@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+");
  static RegExp phoneRegExp = RegExp(r'((0[3|5|7|8|9])+([0-9]{8})\b)');
  static RegExp characterJapaneseRegex =
      RegExp(r'^[\.a-zA-Z0-9-_+]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$');
  static RegExp dateRegex = RegExp(
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$');
  static RegExp monthYearRegex = RegExp(r'(0[1-9]|10|11|12)(\/|-|\.)[0-9]{2}$');
  static RegExp numberRegex = RegExp(r'[0-9]');
  static RegExp specialCharacter = RegExp(r'[!#%^$*(),?":{}|[<>/\\\]~_=+;]');
  static RegExp specialCharacterAll =
      RegExp(r'[.\- !#%^$*(),?":{}|[<>/\\\]~_=+;]');
  static RegExp time24hRegex = RegExp(r'^([01][0-9]|2[0-3]):[0-5][0-9]$');
  static RegExp time12hRegex =
      RegExp(r'^(0[0-9]|1[0-2]):[0-5][0-9] ([AaPpSsCc][MmAaHc])$');
  static RegExp emojiRegex = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  static RegExp urlRegex = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  /// Check if string has a special character except dot and hyphen
  static bool hasSpecialCharacter(String value) {
    return specialCharacter.allMatches(value).isNotEmpty;
  }

  /// Check if string has a normal character
  static bool hasNumber(String value) {
    return numberRegex.allMatches(value).isNotEmpty;
  }

  /// Check if string has a special character
  static bool hasAllSpecialCharacter(String value) {
    return specialCharacterAll.allMatches(value).isNotEmpty;
  }

  /// Check if string has emoji icon
  static bool hasEmojiIcon(String value) {
    return emojiRegex.allMatches(value).isNotEmpty;
  }

  /// Check if date string correct format
  static bool isCorrectDateFormat(String value) {
    return dateRegex.hasMatch(value);
  }

  /// Check if month year string correct format
  static bool isCorrectMonthYearFormat(String value) {
    return monthYearRegex.hasMatch(value);
  }

  /// Check if time 12H string correct format
  static bool isCorrectTime12hFormat(String value) {
    return time12hRegex.hasMatch(value);
  }

  /// Check if time 24H string correct format
  static bool isCorrectTime24hFormat(String value) {
    return time24hRegex.hasMatch(value);
  }

  /// Check if string has url
  static bool isURL(String url) {
    return urlRegex.hasMatch(url);
  }

  /// Check if string only has number
  static bool onlyNumber(String str) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(str);
  }

  /// Validate

  /// Validate date
  static String? validateDate(
      {required String? value,
      required bool isValidate,
      required String textValid}) {
    if (!isValidate) return null;
    if (value!.isEmpty) {
      return Localizes.pleaseEnter(textValid);
    } else if (!StringUtil.isCorrectDateFormat(value)) {
      return Localizes.incorrectDateFormat.tr;
    }
    return null;
  }

  /// validate time
  static String? validateTime(
      {required String? value,
      required bool isValidate,
      required String textValid}) {
    if (!isValidate) return null;
    if (value!.isEmpty) {
      return Localizes.pleaseEnter(textValid);
    } else if (!StringUtil.isCorrectTime24hFormat(value)) {
      return Localizes.incorrectTimeFormat.tr;
    }
    return null;
  }

  /// Validate email
  static validateEmail(String email) {
    if (Utils.isNull(email)) {
      return Localizes.pleaseEnter(Localizes.emailAddress.tr.toLowerCase());
    }
    // else if (!email.isEmail) {
    else if (!emailRegex.hasMatch(email)) {
      return Localizes.pleaseEnterRightFormat(
          Localizes.emailAddress.tr.toLowerCase());
    }
    return null;
    // return emailRegex.allMatches(email).isNotEmpty;
  }

  /// Replace all sign dots [.] and dash [-]
  static replaceSign(String value) {
    return value.replaceAll(RegExp(r'\.|-| '), '');
  }

  /// Has white space
  static hasWhiteSpace(String value) {
    var split = value.split(" ");
    return split.length > 1;
  }

  static randomString({required int length}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  /// Validate phone
  static String? validatePhone({required String value, bool isValidate: true}) {
    var phone = value.trim();
    if (!isValidate) return null;
    if (phone.isEmpty) {
      return Localizes.pleaseEnter(Localizes.phone.tr.toLowerCase());
    } else if (!value.isPhoneNumber) {
      return Localizes.invalidPhone.tr;
    }
    return null;
  }

  /// Validate password
  static validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!.,@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (Utils.isNull(value)) {
      return Localizes.pleaseEnter(Localizes.password.toLowerCase());
    } else if (!regExp.hasMatch(value)) {
      return Localizes.validatePassword.tr;
    }
    return null;
  }

  /// Format string to cash
  static String formatStringToCash(
      {required cash,
      String? locale,
      int? decimal,
      String? unit,
      String? currency}) {
    if (Utils.isNull(cash)) {
      return "0 đ";
    }
    if (cash is String) {
      cash = double.parse(cash);
    }
    return NumberFormat.currency(
      locale: locale ?? 'vi',
      decimalDigits: decimal ?? 0,
      symbol: !Utils.isNull(unit)
          ? "đ/ $unit"
          : (!Utils.isNull(currency) ? currency : "đ"),
    ).format(cash);
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Localizes.goodMorning.tr;
    }
    if (hour < 17) {
      return Localizes.goodAfterNoon.tr;
    }
    return Localizes.goodEvening.tr;
  }

  static String insertChar(
    String text, {
    String char = " ",
    int step = 4,
  }) {
    String result = "";
    text = text.replaceAll(char, "");
    for (int i = 0; i < text.length; i += step) {
      if (i + step < text.length) {
        var subString = "";
        subString =
            char + text.substring(text.length - i - step, text.length - i);
        result = subString + result;
      } else {
        result = text.substring(0, text.length - i) + result;
      }
    }
    return result;
  }

  static String insertCharAfter(
    String text, {
    String char = " ",
    int step = 4,
  }) {
    String result = "";
    text = text.replaceAll(char, "");
    for (int i = 0; i < text.length; i += step) {
      if (i + step < text.length) {
        var subString = "";
        subString = text.substring(i, i + step) + char;
        result += subString;
      } else {
        result += text.substring(i, text.length);
      }
    }
    return result;
  }

  static String upperAfterSpaceString(String text) {
    for (int i = 0; i < text.length; i++) {
      if (text.substring(i, i + 1) == " " && i + 2 <= text.length) {
        text = text.replaceRange(
            i + 1, i + 2, text.substring(i + 1, i + 2).toUpperCase());
      }
      if (i == 0 && text.substring(0, 1) != " ") {
        text = text.replaceRange(0, 1, text.substring(0, 1).toUpperCase());
      }
    }
    return text;
  }

  static String changeFormPaymentCard(
    String text, {
    String char = " ",
    String formChar = "x",
    int step = 4,
  }) {
    String result = "";
    text = text.replaceAll(char, "");
    var textChangeForm = "";
    var length = text.length < 12 ? text.length : 12;
    for (int i = 0; i < length; i++) {
      textChangeForm += formChar;
    }
    if (text.length > 12) {
      result = insertCharAfter(textChangeForm) +
          char +
          text.substring(12, text.length);
    } else {
      result = insertCharAfter(textChangeForm);
    }
    return result;
  }
}
