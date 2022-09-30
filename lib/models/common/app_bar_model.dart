import 'package:flutter/material.dart';

class AppBarModel {
  final bool isBack; // Is back
  final String? title; // Title
  bool isBackground = false; // Is background
  bool shadow = false; // Is background
  final List<Widget>? actions; // Actions
  final Widget? titleWidget; // Title widget
  final Function? onBack;
  final Widget? iconBack;
  final bool centerTitle;

  AppBarModel({
    required this.isBack,
    this.title,
    this.actions,
    this.isBackground = false,
    this.shadow = false,
    this.titleWidget,
    this.onBack,
    this.iconBack,
    this.centerTitle = true,
  });
}
