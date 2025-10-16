import 'package:flutter/material.dart';

class AppConstant {
  static const int androidAppVersion = 1;
  static const int iOSAppVersion = 1;
  static const String version = "1.0.0";

  static const String appName = 'Abejita';
  static const String projectName = 'TuCapital';
}

class AppScreen {
  static const int animationDuration = 400;
  static const double maxMobileWidth = 600;
  static const double standardPadding = 16.0;
  static final BorderRadius borderRadius = BorderRadius.circular(standardPadding);
  static bool isWide(BuildContext context) => MediaQuery.of(context).size.width >= maxMobileWidth;
}
