import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/services/location_service.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/values/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;

class LocationSwitchWidget extends StatefulWidget {
  Key? key; // Value

  LocationSwitchWidget({
    this.key,
  });

  @override
  _LocationSwitchWidgetState createState() => _LocationSwitchWidgetState();
}

class _LocationSwitchWidgetState extends State<LocationSwitchWidget>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;
  bool value = false; // Value widget

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation =
        AlignmentTween(begin: Alignment.centerRight, end: Alignment.centerLeft)
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.linear));

    Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
      var val = status == ServiceStatus.enabled;
      Globals.isRequestingLocation.value = false;
      handlerActionLocation(val);
    });
    checkLocationStatus();
  }

  checkLocationStatus() async {
    var val = await LocationService.isLocationServiceEnabled();
    handlerActionLocation(val);
  }

  handlerActionLocation(bool val) {
    if (val)
      _animationController.forward();
    else
      _animationController.reverse();
    setState(() {
      value = val;
    });
  }

  checkLocation() async {
    var val = await LocationService.isLocationServiceEnabled();
    handlerActionLocation(await processWhenNotHavePermission(val));
  }

  requestLocationServiceOn() async {
    var enable = await LocationService.isLocationServiceEnabled();
    if (!enable) {
      Globals.isRequestingLocation.value = true;
      await Location().requestService();
    } else {
      handlerActionLocation(await processWhenNotHavePermission(enable));
    }
  }

  Future<bool> processWhenNotHavePermission(bool enable) async {
    bool val = enable;
    if (!val) {
      LocationPermission permission = await this.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        val = false;
        openAppSettings();
      } else if (permission == LocationPermission.denied) {
        val = false;
      }
    }

    return val;
  }

  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return !(permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever);
  }

  Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission;
  }

  @override
  void didUpdateWidget(covariant LocationSwitchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // checkLocation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              // _animationController.reverse();
            } else {
              // _animationController.forward();
            }
            if (value) {
              openAppSettings();
            } else {
              requestLocationServiceOn();
            }
          },
          child: Container(
            width: 56.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? Colors.green
                  : Colors.grey400,
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
                            Localizes.on.tr,
                            style:
                                CommonStyle.textSmallBold(color: Colors.white),
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
                            Localizes.off.tr,
                            style: CommonStyle.textSmallBold(
                              color: Colors.white,
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
