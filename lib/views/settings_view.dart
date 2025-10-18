import 'package:abejita/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  static const String routeName = '/settings';
  static const String title = 'Ajustes';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: SafeArea(child: Center(child: Text("SettingsView"))),
    );
  }
}
