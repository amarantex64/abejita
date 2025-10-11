import 'package:abejita/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ContactsView extends StatelessWidget {
  static const String routeName = '/contacts';

  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        hoverElevation: 5,
        child: Icon(LucideIcons.user_round_plus),
      ),
      child: Center(child: Text("ContactsView")),
    );
  }
}
