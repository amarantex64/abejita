import 'package:abejita/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class LoansView extends StatelessWidget {
  static const String routeName = '/loans';

  const LoansView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: SafeArea(child: Center(child: Text("LoansView"))));
  }
}
