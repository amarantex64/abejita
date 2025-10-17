import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, kIsWasm;
import 'package:flutter/material.dart';

class AppConstant {
  static const int androidAppVersion = 1;
  static const int iOSAppVersion = 1;
  static const String version = "1.0.0";

  static const String appName = 'Abejita';
  static const String projectName = 'TuCapital';
  static final bool isMobile = Platform.isAndroid || Platform.isFuchsia || Platform.isIOS;
  static final bool isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  static final bool isWeb = kIsWeb || kIsWasm;
}

class AppScreen {
  static const int animationDuration = 400;
  static const double maxMobileWidth = 600;
  static const double standardPadding = 16.0;
  static final BorderRadius borderRadius = BorderRadius.circular(standardPadding);
  static bool isWide(BuildContext context) => MediaQuery.of(context).size.width >= maxMobileWidth;
}
