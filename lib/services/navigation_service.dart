import 'package:abejita/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationService {
  static BuildContext? globalContext;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void registerContext(BuildContext context, {bool update = false}) {
    if (globalContext == null || update) {
      globalContext = context;
    }
  }

  static void navigateTo(int index) {
    final page = appPagesRoutes[index];
    if (Get.currentRoute != page.name) {
      navigatorKey.currentState?.pushNamed(page.name, arguments: page.arguments);
    }
  }

  static int get indexOfRoute => getIndexFromRouteName(Get.currentRoute);

  static int getIndexFromRouteName(String name) => appPagesRoutes.indexWhere((r) => r.name == name);
}

class AppPageNavigation extends GetPage {
  final IconData? icon;
  final IconData? selectedIcon;
  final Color? indicatorColor;
  final Color? iconColor;
  final bool? disabled;
  final String? tooltip;

  AppPageNavigation({
    required super.name,
    required super.page,
    this.icon,
    this.tooltip,
    this.indicatorColor,
    this.selectedIcon,
    this.iconColor,
    this.disabled,
    super.title,
    super.participatesInRootNavigator,
    super.gestureWidth,
    // RouteSettings settings,
    super.maintainState = true,
    super.curve = Curves.linear,
    super.alignment,
    super.parameters,
    super.opaque = true,
    super.transitionDuration,
    super.popGesture,
    super.binding,
    super.bindings = const [],
    super.transition,
    super.customTransition,
    super.fullscreenDialog = false,
    super.children = const <GetPage>[],
    super.middlewares,
    super.unknownRoute,
    super.arguments,
    super.showCupertinoParallax = true,
    super.preventDuplicates = true,
  });
}
