import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class NumberField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onFieldSubmitted;
  final Widget? prefixIcon;
  final bool? enabled;
  final double min;
  final double max;
  final double increment;
  final double? initialValue;
  final bool needDecimal;

  const NumberField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.initialValue,
    this.onFieldSubmitted,
    this.enabled,
    this.increment = 1,
    this.min = 0,
    this.max = double.infinity,
    this.needDecimal = false,
  });

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      controller.text = widget.needDecimal
          ? widget.initialValue!.toStringAsFixed(2)
          : widget.initialValue!.toInt().toString();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged != null ? (value) => widget.onChanged!(double.tryParse(value) ?? 0) : null,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      controller: controller,
      validator: widget.validator,
      obscureText: false,
      onFieldSubmitted: widget.onFieldSubmitted != null
          ? (value) => widget.onFieldSubmitted!(double.tryParse(value) ?? 0)
          : null,
      enabled: widget.enabled ?? true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))],
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        filled: true,
        enabled: widget.enabled ?? true,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.all(12),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                double number = double.tryParse(controller.text) ?? 0;
                if (number > widget.min) {
                  number -= widget.increment;
                  controller.text = widget.needDecimal ? number.toStringAsFixed(2) : number.toInt().toString();
                  setState(() {});
                  if (widget.onChanged != null) widget.onChanged!(number);
                }
              },
              icon: Icon(LucideIcons.minus, size: 24),
            ),
            IconButton(
              onPressed: () {
                double number = double.tryParse(controller.text) ?? 0;
                if (number <= widget.max) {
                  number += widget.increment;
                  controller.text = widget.needDecimal ? number.toStringAsFixed(2) : number.toInt().toString();
                  setState(() {});
                  if (widget.onChanged != null) widget.onChanged!(number);
                }
              },
              icon: Icon(LucideIcons.plus, size: 24),
            ),
          ],
        ),
      ),
    );
  }
}
