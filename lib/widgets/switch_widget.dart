import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';

// ignore: must_be_immutable
class SwitchWidget extends StatefulWidget {
  bool value; // Value
  static final GlobalKey<_SwitchWidgetState> globalKey = GlobalKey();
  final ValueChanged<bool> onChanged; // Value change
  final Color? activeColor; // Active color
  final Color? inactiveColor; // In active color
  final String? activeText; // Active text
  final String? inactiveText; // In active text
  final Color? activeTextColor; // Active text color
  final Color? inactiveTextColor; // In active text color
  bool enable = true;

  SwitchWidget({
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey400,
    this.activeText = "On",
    this.inactiveText = "Off",
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.white,
    this.enable = true,
  }) : super(key: globalKey);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;
  bool value = false; // Value widget

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation =
        AlignmentTween(begin: Alignment.centerRight, end: Alignment.centerLeft)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.linear));

    if (widget.value)
      _animationController.forward();
    else
      _animationController.reverse();
  }

  @override
  void didUpdateWidget(covariant SwitchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value)
      _animationController.forward();
    else
      _animationController.reverse();
    setState(() {
      value = widget.value;
    });
  }

  void turnOn() {
    _animationController.reverse();
    // this.value = true;
    setState(() {
      value = true;
    });
  }

  void turnOff() {
    // this.value = false;
    _animationController.reverse();
    setState(() {
      value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.enable
              ? () {
                  if (this.value) {
                    _animationController.forward();
                  } else
                    _animationController.reverse();
                  setState(() {
                    this.value = !this.value;
                  });
                  widget.onChanged(this.value);
                }
              : null,
          child: Container(
            width: 56.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? widget.activeColor
                  : widget.inactiveColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 0.0, left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleAnimation.value == Alignment.centerLeft
                      ? Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 4.0),
                          child: Text(
                            widget.activeText!,
                            style: CommonStyle.textSmallBold(
                                color: widget.activeTextColor),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 24.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerRight
                      ? Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 8.0),
                          child: Text(
                            widget.inactiveText!,
                            style: CommonStyle.textSmallBold(
                              color: widget.inactiveTextColor,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
