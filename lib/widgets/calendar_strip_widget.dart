import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/enums/language.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';
import 'package:flutter_app/values/globals.dart';

class CalendarStripWidget extends StatefulWidget {
  // This widget is the root of your application.
  final Function onDateSelected; // On date selected
  final Function? onWeekSelected; // On week selected
  final Function? dateTileBuilder; // Date title builder
  final BoxDecoration? containerDecoration; // Container decoration
  final Function? monthNameWidget; // Month name widget
  final Color? iconColor; // Icon color
  final DateTime selectedDate; // Selected date from calendar strip widget
  final DateTime startDate; // Start date can choose
  final DateTime endDate; // End date can't choose
  final List<DateTime>? markedDates; // Marked dates
  final bool addSwipeGesture; // Add option can swipe gesture
  final bool showIconPreview; // Show icon preview
  final bool showMonthLabel; // Show month label
  final bool weekStartsOnSunday; // Week start on sunday
  final Icon? rightIcon; // Right icon
  final Icon? leftIcon;
  final bool isChangeDateSelected;

  CalendarStripWidget({
    this.addSwipeGesture = false,
    this.weekStartsOnSunday = false,
    required this.onDateSelected,
    this.onWeekSelected,
    this.dateTileBuilder,
    this.containerDecoration,
    this.monthNameWidget,
    this.iconColor,
    required this.selectedDate,
    required this.startDate,
    required this.endDate,
    this.showIconPreview = false,
    this.markedDates,
    this.showMonthLabel = true,
    this.rightIcon,
    this.leftIcon,
    this.isChangeDateSelected = false,
  });

  State<CalendarStripWidget> createState() =>
      CalendarStripState(selectedDate, startDate, endDate);
}

class CalendarStripState extends State<CalendarStripWidget>
    with TickerProviderStateMixin {
  static const sizeSelectedDay = 32.0;

  DateTime currentDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late DateTime selectedDate;
  late String monthLabel;
  bool inBetweenMonths = false;
  late DateTime rowStartingDate;
  double opacity = 0.0;
  late DateTime lastDayOfMonth;
  late TextStyle monthLabelStyle = CommonStyle.textLargeBold();
  TextStyle selectedDateStyle =
      CommonStyle.textMedium(color: Colors.white).merge(TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
  ));
  bool isOnEndingWeek = false, isOnStartingWeek = false;
  bool doesDateRangeExists = false;
  late DateTime today;

  List<String> monthLabels = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]; // list month labels

  List<String> dayLabels = Globals.language.value.code ==
          Language.vietnamese.code
      ? ["TH 2", "TH 3", "TH 4", "TH 5", "TH 6", "TH 7", "CN"]
      : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]; // list day labels

  CalendarStripState(
      DateTime selectedDate, DateTime startDate, DateTime endDate) {
    today = getDateOnly(DateTime.now());
    lastDayOfMonth = DateUtil.getLastDayOfMonth(currentDate);
    runPresetsAndExceptions(selectedDate, startDate, endDate);
    this.selectedDate = currentDate;
  }

  /// Run presets and exceptions
  runPresetsAndExceptions(selectedDate, startDate, endDate) {
    if ((startDate == null && endDate != null) ||
        (startDate != null && endDate == null)) {
      throw Exception(
          "Both 'startDate' and 'endDate' are mandatory to specify range");
    } else if (selectedDate != null &&
        (isDateBefore(selectedDate, startDate) ||
            isDateAfter(selectedDate, endDate))) {
      throw Exception("Selected Date is out of range from start and end dates");
    } else if (startDate == null && startDate == null) {
      doesDateRangeExists = false;
    } else {
      doesDateRangeExists = true;
    }
    if (doesDateRangeExists) {
      if (endDate != null && isDateAfter(currentDate, endDate)) {
        currentDate = getDateOnly(startDate);
      } else if (isDateBefore(currentDate, startDate)) {
        currentDate = getDateOnly(startDate);
      }
    }
    if (selectedDate != null) {
      currentDate = getDateOnly(nullOrDefault(selectedDate, currentDate));
    }
  }

  @override
  void didUpdateWidget(CalendarStripWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate &&
        (isDateBefore(widget.selectedDate, widget.startDate) ||
            isDateAfter(widget.selectedDate, widget.endDate))) {
      throw Exception("Selected Date is out of range from start and end dates");
    } else {
      setState(() {
        selectedDate = getDateOnly(widget.selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    int subtractDuration = widget.weekStartsOnSunday == true
        ? currentDate.weekday
        : currentDate.weekday - 1;
    rowStartingDate = currentDate.subtract(Duration(days: subtractDuration));
    var dateRange = calculateDateRange(null);
    setState(() {
      isOnEndingWeek = dateRange['isEndingWeekOnRange']!;
      isOnStartingWeek = dateRange['isStartingWeekOnRange']!;
    });
  }

  /// Get last day of month
  int getLastDayOfMonth(rowStartingDay) {
    return DateUtil.getLastDayOfMonth(
            currentDate.add(Duration(days: rowStartingDay)))
        .day;
  }

  /// Get month name
  String getMonthName(
    DateTime dateObj,
  ) {
    return monthLabels[dateObj.month - 1];
  }

  /// Get month label
  String getMonthLabel() {
    DateTime startingDayObj = rowStartingDate,
        endingDayObj = rowStartingDate.add(Duration(days: 6));
    String label = "";
    if (startingDayObj.month == endingDayObj.month) {
      label = "${getMonthName(startingDayObj)} ${startingDayObj.year}";
    } else {
      var startingDayYear =
          "${startingDayObj.year == endingDayObj.year ? "" : startingDayObj.year}";
      label =
          "${getMonthName(startingDayObj)} $startingDayYear / ${getMonthName(endingDayObj)} ${endingDayObj.year}";
    }
    return label;
  }

  /// Is date before
  isDateBefore(date1, date2) {
    DateTime _date1 = DateTime(date1.year, date1.month, date1.day);
    DateTime _date2 = DateTime(date2.year, date2.month, date2.day);
    return _date1.isBefore(_date2);
  }

  /// Is date after
  isDateAfter(date1, date2) {
    DateTime _date1 = DateTime(date1.year, date1.month, date1.day);
    DateTime _date2 = DateTime(date2.year, date2.month, date2.day);
    return _date1.isAfter(_date2);
  }

  /// Get date only
  DateTime getDateOnly(DateTime dateTimeObj) {
    return DateTime.utc(dateTimeObj.year, dateTimeObj.month, dateTimeObj.day);
  }

  /// Is date marked
  bool isDateMarked(date) {
    date = getDateOnly(date);
    bool _isDateMarked = false;
    if (widget.markedDates != null) {
      widget.markedDates?.forEach((DateTime eachMarkedDate) {
        if (getDateOnly(eachMarkedDate) == date) {
          _isDateMarked = true;
        }
      });
    }
    return _isDateMarked;
  }

  /// Calculate date range
  Map<String, bool> calculateDateRange(mode) {
    if (doesDateRangeExists) {
      DateTime _nextRowStartingDate;
      DateTime weekStartingDate, weekEndingDate;
      if (mode != null) {
        _nextRowStartingDate = mode == "PREV"
            ? rowStartingDate.subtract(Duration(days: 7))
            : rowStartingDate.add(Duration(days: 7));
      } else {
        _nextRowStartingDate = rowStartingDate;
      }
      weekStartingDate = getDateOnly(_nextRowStartingDate);
      weekEndingDate = getDateOnly(_nextRowStartingDate.add(Duration(days: 6)));
      bool isStartingWeekOnRange =
          isDateAfter(widget.startDate, weekStartingDate);
      bool isEndingWeekOnRange = isDateBefore(widget.endDate, weekEndingDate);
      return {
        "isEndingWeekOnRange": isEndingWeekOnRange,
        "isStartingWeekOnRange": isStartingWeekOnRange
      };
    } else {
      return {"isEndingWeekOnRange": false, "isStartingWeekOnRange": false};
    }
  }

  /// On selected row
  onSelectedRow(DateTime rowDate) {
    setState(() {
      rowStartingDate = rowDate
          .subtract(Duration(days: rowDate.weekday - 1)); //rowDate.weekday
    });
  }

  /// On previous row
  onPrevRow() {
    var dateRange = calculateDateRange("PREV");
    setState(() {
      rowStartingDate = rowStartingDate.subtract(Duration(days: 7));
      widget.onWeekSelected!(rowStartingDate);
      isOnEndingWeek = dateRange['isEndingWeekOnRange']!;
      isOnStartingWeek = dateRange['isStartingWeekOnRange']!;
    });
  }

  /// On next row
  onNextRow() {
    var dateRange = calculateDateRange("NEXT");
    setState(() {
      rowStartingDate = rowStartingDate.add(Duration(days: 7));
      widget.onWeekSelected!(rowStartingDate);
      isOnEndingWeek = dateRange['isEndingWeekOnRange']!;
      isOnStartingWeek = dateRange['isStartingWeekOnRange']!;
    });
  }

  /// On date tap
  onDateTap(date) {
    if (!doesDateRangeExists) {
      setState(() {
        selectedDate = date;
        widget.onDateSelected(date);
      });
    } else if (!isDateBefore(date, widget.startDate) &&
        !isDateAfter(date, widget.endDate)) {
      setState(() {
        selectedDate = date;
        widget.onDateSelected(date);
      });
    } else {}
  }

  /// Check null or default
  nullOrDefault(var normalValue, var defaultValue) {
    if (normalValue == null) {
      return defaultValue;
    }
    return normalValue;
  }

  /// Render month label widget
  monthLabelWidget(monthLabel) {
    if (widget.monthNameWidget != null) {
      return widget.monthNameWidget!(monthLabel);
    }
    return Container(
        child: Text(monthLabel, style: monthLabelStyle),
        padding: EdgeInsets.only(top: 7, bottom: 3));
  }

  /// Render right icon widget
  rightIconWidget() {
    if (!isOnEndingWeek) {
      return InkWell(
        child: widget.rightIcon ??
            Icon(
              CupertinoIcons.right_chevron,
              size: 30,
              color: nullOrDefault(widget.iconColor, Colors.black),
            ),
        onTap: onNextRow,
        splashColor: Colors.grey100,
      );
    } else {
      return Container(width: 20);
    }
  }

  /// Render left icon widget
  leftIconWidget() {
    if (!isOnStartingWeek) {
      return InkWell(
        child: widget.leftIcon ??
            Icon(
              CupertinoIcons.left_chevron,
              size: 30,
              color: nullOrDefault(widget.iconColor, Colors.black),
            ),
        onTap: onPrevRow,
        splashColor: Colors.grey100,
      );
    } else {
      return Container(width: 20);
    }
  }

  /// Check out of range status
  checkOutOfRangeStatus(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    if (widget.endDate != null) {
      if (!isDateBefore(date, widget.startDate) &&
          !isDateAfter(date, widget.endDate)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  /// On strip drag
  onStripDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0 || (widget.addSwipeGesture == false))
      return;
    if (details.primaryVelocity! < 0) {
      if (!isOnEndingWeek) {
        onNextRow();
      }
    } else {
      if (!isOnStartingWeek) {
        onPrevRow();
      }
    }
  }

  /// Render build date row
  buildDateRow() {
    List<Widget> currentWeekRow = [];
    if (widget.isChangeDateSelected) {
      onSelectedRow(selectedDate);
    }

    for (var eachDay = 0; eachDay < 7; eachDay++) {
      var index = eachDay;
      currentWeekRow.add(dateTileBuilder(
          rowStartingDate.add(Duration(days: eachDay)), selectedDate, index));
    }

    monthLabel = getMonthLabel();
    return Column(children: [
      widget.showMonthLabel ? monthLabelWidget(monthLabel) : Container(),
      Container(
          margin: EdgeInsets.symmetric(vertical: Constants.margin12),
          padding: EdgeInsets.all(Constants.padding),
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) =>
                onStripDrag(details),
            child: Row(children: [
              widget.showIconPreview ? leftIconWidget() : Container(),
              Expanded(child: Row(children: currentWeekRow)),
              widget.showIconPreview ? rightIconWidget() : Container(),
            ]),
          ))
    ]);
  }

  /// Render date title builder
  Widget dateTileBuilder(DateTime date, DateTime selectedDate, int rowIndex) {
    bool isDateOutOfRange = checkOutOfRangeStatus(date);
    String dayName = dayLabels[date.weekday - 1];
    if (widget.dateTileBuilder != null) {
      return Expanded(
        child: SlideFadeTransition(
          delay: 30 + (30 * rowIndex),
          id: "${date.day}${date.month}${date.year}",
          curve: Curves.ease,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () => onDateTap(date),
            child: Container(
              child: widget.dateTileBuilder!(date, selectedDate, rowIndex,
                  dayName, isDateMarked(date), isDateOutOfRange),
            ),
          ),
        ),
      );
    }

    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    var normalStyle = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        color: isDateOutOfRange
            ? Colors.grey100
            //     :
            // dayLabels[date.weekday - 1] == 'Sun' ||
            //             dayLabels[date.weekday - 1] == 'Sat'
            //         ? Colors.pink
            : Colors.text);
    var dayTextWidget = Text(date.day.toString(),
        style: !isSelectedDate ? normalStyle : selectedDateStyle);

    return Expanded(
      child: SlideFadeTransition(
        delay: 30 + (30 * rowIndex),
        id: "${date.day}${date.month}${date.year}",
        curve: Curves.ease,
        child: InkWell(
          onTap: () => onDateTap(date),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(top: isDateMarked(date) ? 0 : 0),
                child: Column(
                  children: [
                    Text(
                      dayLabels[date.weekday - 1],
                      style: TextStyle(
                        fontSize: 14,
                        color: !isSelectedDate
                            ?
                            // dayLabels[date.weekday - 1] == 'Sun' ||
                            //             dayLabels[date.weekday - 1] == 'Sat'
                            //         ? Colors.pink :
                            Colors.textLight
                            : Colors.textLight,
                      ),
                    ),
                    Container(
                      height: sizeSelectedDay,
                      width: sizeSelectedDay,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 8),
                      // padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: !isSelectedDate ? Colors.white : Colors.primary,
                        borderRadius: BorderRadius.all(
                            Radius.circular(sizeSelectedDay / 2)),
                        boxShadow: !isSelectedDate
                            ? null
                            : [CommonStyle.shadowOffset()],
                      ),
                      child: dayTextWidget,
                    ),
                  ],
                ),
              ),
              // isDateMarked(date)
              //     ?
              Container(
                margin: EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDateMarked(date)
                        ? Colors.primary
                        : Colors.transparent),
              )
              // : Container(),
            ],
          ),
        ),
      ),
    );
  }

  build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildDateRow(),
        ],
      ),
      decoration: widget.containerDecoration != null
          ? widget.containerDecoration
          : BoxDecoration(),
    );
  }
}

class SlideFadeTransition extends StatefulWidget {
  final Widget child;
  final int delay;
  final String id;
  final Curve curve;

  SlideFadeTransition({
    required this.child,
    required this.id,
    required this.delay,
    required this.curve,
  });

  @override
  SlideFadeTransitionState createState() => SlideFadeTransitionState();
}

class SlideFadeTransitionState extends State<SlideFadeTransition>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    final _curve = CurvedAnimation(
        curve: widget.curve != null ? widget.curve : Curves.decelerate,
        parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero)
            .animate(_curve);

    if (widget.delay == null) {
      if (!_disposed) _animController.forward();
    } else {
      _animController.reset();
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (!_disposed) _animController.forward();
      });
    }
  }

  @override
  void didUpdateWidget(SlideFadeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.id != oldWidget.id) {
      _animController.reset();
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (!_disposed) _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(position: _animOffset, child: widget.child),
      opacity: _animController,
    );
  }
}
