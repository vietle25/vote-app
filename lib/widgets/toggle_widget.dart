import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/constants.dart';

class ToggleWidget extends StatefulWidget {
  bool value; // Value
  // static final GlobalKey<_ToggleWidgetState> globalKey = GlobalKey();
  final ValueChanged<bool> onChanged; // Value change
  final Color? activeColor; // Active color
  final Color? inactiveColor; // In active color
  final String? activeText; // Active text
  final String? inactiveText; // In active text
  final Color? activeTextColor; // Active text color
  final Color? inactiveTextColor; // In active text color
  bool enable = true;

  ToggleWidget({
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey400,
    this.activeText = "Yes",
    this.inactiveText = "No",
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.white,
    this.enable = true,
  });

  @override
  _ToggleWidgetState createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget>
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
  void didUpdateWidget(covariant ToggleWidget oldWidget) {
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
        return Material(
          color: Colors.grey200,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
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
              width: 66.0,
              height: 26.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey200,
                // color: _circleAnimation.value == Alignment.centerLeft
                //     ? widget.activeColor
                //     : widget.inactiveColor,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 33,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: Colors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 32.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: Constants.margin8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.activeText!,
                          style: CommonStyle.text(color: Colors.white),
                        ),
                        Text(
                          widget.inactiveText!,
                          style: CommonStyle.text(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
