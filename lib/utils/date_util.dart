import 'package:date_format/date_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static final String formatDay = 'DD/MM/YYYY';
  static final String formatDate2 = 'd/M/y';
  static final String formatMonthYear = 'MM/y';
  static final String formatDateSql = 'YYYY-MM-DD';
  static final String formatDateTimeZone = 'YYYY-MM-DD HH:mm:ss.SSSZZZ';
  static final String formatTime = 'HH:mm';
  static final String formatTimeSecond = 'HH:mm:ss';
  static final String formatDateTime = 'DD/MM/YYYY HH:mm:ss';
  static final String formatDateTimeSql = 'YYYY-MM-DD hh:mm:ss';

  /// Convert to two digits
  static String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  /// Get time now
  static DateTime now() {
    return DateTime.now();
  }

  /// Parse now with [format]
  static String parseNow(String format) {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(format);
    return formatter.format(now);
  }

  /// Compare date with [value1] and [value2]
  static int compareDate(String value1, String value2, String format) {
    DateFormat formatter = DateFormat(format);
    DateTime date1 = formatter.parse(value1);
    DateTime date2 = formatter.parse(value2);
    if (date1.isAfter(date2)) {
      return 1;
    } else if (date1.isBefore(date2)) {
      return -1;
    }
    return 0;
  }

  /// Convert date from format to format
  static String convertFromFormatToFormat(date, fromFormat, toFormat) {
    DateFormat fromFormatter = DateFormat(fromFormat);
    DateFormat toFormatter = DateFormat(toFormat);
    DateTime dateTime = fromFormatter.parse(date);
    return toFormatter.format(dateTime);
  }

  /// Format by seconds
  static String formatBySeconds(Duration duration) =>
      twoDigits(duration.inSeconds.remainder(60));

  /// Format by minutes
  static String formatByMinutes(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return '$twoDigitMinutes:${formatBySeconds(duration)}';
  }

  /// Format by hours
  static String formatByHours(Duration duration) {
    return '${twoDigits(duration.inHours)}:${formatByMinutes(duration)}';
  }

  /// Convert string to date
  static DateTime convertStringToDate(String date, String fromFormat) {
    String dtStr = "";
    DateFormat formatter;
    if (fromFormat != DateUtil.formatDay &&
        fromFormat != DateUtil.formatDate2 &&
        fromFormat != DateUtil.formatDateTime) {
      dtStr = DateTime.parse(date).toString();
      formatter = DateFormat(fromFormat);
    } else {
      var inputFormat = DateFormat(fromFormat);
      var dateVN = inputFormat.parse(date);
      formatter = DateFormat("y-M-d");
      dtStr = formatter.parse("$dateVN").toString();
    }
    DateTime dateTimeFromStr = formatter.parse(dtStr, true).toLocal();
    return dateTimeFromStr;
  }

  /// Convert date to string
  static String convertDateToString(DateTime date, String toFormat) {
    initializeDateFormatting();
    DateFormat formatter = DateFormat(toFormat);
    return formatter.format(date);
  }

  /// Convert string to date
  static String convertToServerDate(String str) {
    var date = formatDate(
        DateUtil.convertStringToDate(str, DateUtil.formatDate2),
        [yyyy, "-", mm, "-", dd, " ", HH, ':', nn, ':', ss, ".", SSS, z]);
    return date;
  }

  /// Convert string to month year
  static String convertToServerMonthYear(String str) {
    var year = str.substring(str.length - 2, str.length);
    var century = DateTime.now().year.toString();
    century = century.substring(0, century.length - 2);
    str = "1/" + str.substring(0, str.length - 2) + century + year;
    return convertToServerDate(str);
  }

  /// Convert string to month year datetime
  static DateTime convertToDatetimeMonthYear(String str) {
    var year = str.substring(str.length - 2, str.length);
    var century = DateTime.now().year.toString();
    century = century.substring(0, century.length - 2);
    str = "1/" + str.substring(0, str.length - 2) + century + year;
    return DateFormat(DateUtil.formatDate2).parse(str);
  }

  /// Convert string to date
  static String convertNowToServerTime() {
    var date = formatDate(DateTime.now(),
        [yyyy, "-", mm, "-", dd, " ", HH, ':', nn, ':', ss, ".", SSS, z]);
    return date;
  }

  static String formatTimeA(String date) {
    var dtStr = DateTime.parse(date).toLocal();
    DateFormat formatter = DateFormat('hh:mm a - d/M/y');
    return formatter.format(dtStr);
  }

  static String formatDMY(String date) {
    var dtStr = DateTime.parse(date);
    DateFormat formatter = DateFormat('d/M/y');
    return formatter.format(dtStr);
    return dtStr.toString();
  }

  static String formatDDMMYY(String date) {
    var dtStr = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dtStr);
    return dtStr.toString();
  }

  static String formatMMYY(String date) {
    var dtStr = DateTime.parse(date);
    DateFormat formatter = DateFormat('MM/yy');
    return formatter.format(dtStr);
    return dtStr.toString();
  }

  /// Get last day of month
  static DateTime getLastDayOfMonth(DateTime month) {
    DateTime firstDayOfMonth = DateTime(month.year, month.month);
    DateTime nextMonth = firstDayOfMonth.add(Duration(days: 32));
    DateTime firstDayOfNextMonth = DateTime(nextMonth.year, nextMonth.month);
    return firstDayOfNextMonth.subtract(Duration(days: 1));
  }
}
