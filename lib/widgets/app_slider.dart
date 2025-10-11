import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  final double? min;
  final double max;
  final double? increments;
  final double? initialValue;
  final ValueChanged<double> onChanged;
  final Color? activeColor;
  final bool showValueText, showLabel;
  final TextAlign? textAlignValueText;
  final String? prefixValueText, suffixValueText;

  const AppSlider({
    super.key,
    this.showValueText = false,
    this.showLabel = true,
    this.textAlignValueText,
    this.suffixValueText,
    this.prefixValueText,
    this.activeColor,
    this.initialValue,
    this.min,
    required this.max,
    this.increments,
    required this.onChanged,
  });
  @override
  State<StatefulWidget> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  late double value;
  int? divisions;

  @override
  void initState() {
    super.initState();
    divisions = widget.increments != null ? (widget.max / widget.increments!).round() : null;
    value = widget.initialValue ?? (widget.min ?? 1);
  }

  double get valueSelected {
    if (value > widget.max) {
      value = widget.max;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final slider = Slider(
      value: valueSelected,
      activeColor: widget.activeColor,
      min: widget.min ?? 1,
      max: widget.max,
      divisions: divisions,
      label: widget.showLabel ? "${value.round()}" : null,
      allowedInteraction: SliderInteraction.slideThumb,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
        widget.onChanged(value);
      },
    );

    return (widget.showValueText)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${widget.prefixValueText ?? ""}${value.round()}${widget.suffixValueText ?? ""}".trim(),
                textAlign: widget.textAlignValueText ?? TextAlign.left,
              ),
              slider,
            ],
          )
        : slider;
  }
}
