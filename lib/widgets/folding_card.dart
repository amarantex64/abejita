import 'package:abejita/app_constant.dart';
import 'package:flutter/material.dart';

class FoldingCard extends StatefulWidget {
  const FoldingCard({
    super.key,
    required this.title,
    required this.showButtonContent,
    required this.hideButtonContent,
    this.padding = const EdgeInsets.all(AppScreen.standardPadding),
    this.animationDuration = const Duration(milliseconds: AppScreen.animationDuration),
    this.iconTitle,
    this.onCollapsed,
    required this.startExpanded,
    required this.child,
  });

  final EdgeInsets padding;
  final Widget? iconTitle;
  final Widget title, child;
  final Widget showButtonContent, hideButtonContent;
  final Duration animationDuration;
  final bool startExpanded;
  final ValueChanged<bool>? onCollapsed;

  @override
  State<FoldingCard> createState() => _FoldingCardState();
}

class _FoldingCardState extends State<FoldingCard> {
  bool isCardExpanded = true;

  @override
  void initState() {
    super.initState();
    isCardExpanded = widget.startExpanded;
  }

  @override
  Widget build(Object context) {
    return Card(
      child: Padding(
        padding: widget.padding,
        child: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                if (widget.iconTitle != null) widget.iconTitle!,
                Expanded(child: widget.title),
                TextButton(
                  child: isCardExpanded ? widget.hideButtonContent : widget.showButtonContent,
                  onPressed: () => setState(() {
                    isCardExpanded = !isCardExpanded;
                    if (widget.onCollapsed != null) {
                      widget.onCollapsed!(isCardExpanded);
                    }
                    setState(() {});
                  }),
                ),
              ],
            ),
            AnimatedSize(
              duration: widget.animationDuration,
              child: Visibility(visible: isCardExpanded, child: widget.child),
            ),
          ],
        ),
      ),
    );
  }
}
