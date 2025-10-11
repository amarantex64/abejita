import 'package:abejita/services/navigation_service.dart';
import 'package:abejita/views/contacts_view.dart';
import 'package:abejita/views/home_view.dart';
import 'package:abejita/views/loans_view.dart';
import 'package:abejita/views/settings_view.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    /*
    return AuthService.isLoggedIn
        ? null
        : RouteSettings(name: LoginScreen.routeName);
    */
    return null;
  }
}

final List<AppPageNavigation> appPagesRoutes = [
  AppPageNavigation(
    icon: LucideIcons.book_open_text,
    iconColor: Colors.amber,
    name: HomeView.routeName,
    page: () => HomeView(),
    title: "Resumen",
    maintainState: false,
    preventDuplicates: true,
  ),
  AppPageNavigation(
    icon: LucideIcons.hand_coins,
    iconColor: Colors.purple,
    name: LoansView.routeName,
    page: () => LoansView(),
    title: "Préstamos",
    maintainState: false,
    preventDuplicates: true,
  ),
  AppPageNavigation(
    icon: LucideIcons.user,
    iconColor: Colors.green,
    name: ContactsView.routeName,
    page: () => ContactsView(),
    title: "Clientes",
    maintainState: false,
    preventDuplicates: true,
  ),
  AppPageNavigation(
    icon: LucideIcons.settings_2,
    iconColor: Colors.deepOrange,
    name: SettingsView.routeName,
    page: () => SettingsView(),
    title: "Ajustes",
    maintainState: false,
    preventDuplicates: true,
  ),
];
