import 'package:flutter/material.dart';

class AppbarIconAction extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final void Function(BuildContext) onPressed;

  const AppbarIconAction({super.key, required this.icon, this.tooltip, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Builder(
      key: key,
      builder: (context) => IconButton(
        icon: Icon(icon),
        iconSize: 16,
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(Colors.white.withAlpha(70)),
        ),
        tooltip: tooltip,
        onPressed: () => onPressed(context),
      ),
    );
  }
}
