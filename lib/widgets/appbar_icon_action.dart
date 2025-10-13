import 'package:flutter/material.dart';

class AppbarIconAction extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final void Function(BuildContext context) onPressed;

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

class AppbarIconToggleAction extends StatefulWidget {
  final IconData icon;
  final String? tooltip;
  final bool? initialValue;
  final void Function(BuildContext context, bool isChecked) onChanged;

  const AppbarIconToggleAction({super.key, required this.icon, this.initialValue, this.tooltip, required this.onChanged});

  @override
  State<AppbarIconToggleAction> createState() => _AppbarIconToggleActionState();
}

class _AppbarIconToggleActionState extends State<AppbarIconToggleAction> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => IconButton(
        icon: Icon(widget.icon),
        iconSize: 16,
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(isChecked ? Colors.white70 : Colors.white24),
        ),
        tooltip: widget.tooltip,
        onPressed: () {
          setState(() => isChecked = !isChecked);
          widget.onChanged(context, isChecked);
        },
      ),
    );
  }
}
