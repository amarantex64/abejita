import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AppNotificationDrawer extends StatelessWidget {
  const AppNotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(LucideIcons.bell, size: 64), SizedBox(height: 10), Text("No tiene notificaciones aún")],
        ),
      ),
    );
  }
}
