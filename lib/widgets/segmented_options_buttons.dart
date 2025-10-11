import 'package:flutter/material.dart';

class SegmentedOptionsItem<T> {
  final T value;
  final String label;
  final Icon? icon;

  const SegmentedOptionsItem({required this.value, required this.label, this.icon});
}

class SegmentedOptionsButtons<T> extends StatefulWidget {
  final List<SegmentedOptionsItem<T>> items;
  final void Function(dynamic value) onChanged;
  final bool? showSelectedIcon;
  final T? initialValue;
  final int? maxLineTextItem;

  const SegmentedOptionsButtons({
    super.key,
    required this.items,
    required this.onChanged,
    this.showSelectedIcon,
    this.initialValue,
    this.maxLineTextItem,
  });

  @override
  State<SegmentedOptionsButtons> createState() => _SegmentedOptionsButtonsState();
}

class _SegmentedOptionsButtonsState<T> extends State<SegmentedOptionsButtons<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      segments: widget.items
          .map(
            (item) => ButtonSegment<T>(
              tooltip: item.label,
              value: item.value,
              label: Text(item.label, maxLines: widget.maxLineTextItem ?? 1, overflow: TextOverflow.visible),
              icon: item.icon,
            ),
          )
          .toList(),
      onSelectionChanged: (value) {
        setState(() => selectedValue = value.first);
        widget.onChanged(selectedValue);
      },
      selected: {selectedValue},
      showSelectedIcon: widget.showSelectedIcon ?? false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
      ),
    );
  }
}
