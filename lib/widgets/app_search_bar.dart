import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AppSearchBar extends StatefulWidget {
  final String hintText;
  final double maxWidth, maxHeight, minHeight;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = "Búsqueda",
    this.maxWidth = 600,
    this.maxHeight = 48,
    this.minHeight = 40,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  bool isEmpty = true;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: widget.hintText,
      hintStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodySmall),
      textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodySmall),
      leading: const Icon(LucideIcons.search, size: 20),
      trailing: isEmpty
          ? null
          : [
              IconButton(
                onPressed: () {
                  isEmpty = true;
                  setState(() => controller.text = "");
                  if (widget.onClear != null) {
                    widget.onClear!();
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!("");
                  }
                },
                icon: const Icon(LucideIcons.circle_x, size: 20),
                splashRadius: 20,
              ),
            ],
      onChanged: (value) {
        if (isEmpty != value.isEmpty) {
          setState(() => isEmpty = value.isEmpty);
        }
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
      constraints: BoxConstraints(minHeight: widget.minHeight, maxHeight: widget.maxHeight, maxWidth: widget.maxWidth),
    );
  }
}
