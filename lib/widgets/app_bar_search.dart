import 'package:abejita/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final TextInputType? keyboardType;
  final TextStyle? titleStyle, hintStyle;
  final Iterable<IconButton>? actions;
  final Color? overlayColor, backgroundColor, backgroundSearchColor;
  final ValueChanged<String>? onChanged, onSubmitted;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;

  const AppBarSearch({
    super.key,
    required this.title,
    this.actions,
    this.elevation = 0,
    this.titleStyle,
    this.hintStyle,
    this.keyboardType,
    this.overlayColor,
    this.backgroundColor,
    this.backgroundSearchColor,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onTapOutside,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(AppScreen.standardPadding),
      child: SearchBar(
        autoFocus: false,
        constraints: const BoxConstraints(
          maxHeight: double.maxFinite,
          minHeight: double.maxFinite,
          maxWidth: AppScreen.maxMobileWidth,
        ),
        hintText: title,
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTapOutside: onTapOutside,
        keyboardType: keyboardType,
        elevation: WidgetStatePropertyAll(elevation),
        backgroundColor: backgroundSearchColor != null ? WidgetStatePropertyAll(backgroundSearchColor) : null,
        overlayColor: overlayColor != null ? WidgetStatePropertyAll(overlayColor) : null,
        hintStyle: hintStyle != null ? WidgetStatePropertyAll(hintStyle) : null,
        textStyle: titleStyle != null ? WidgetStatePropertyAll(titleStyle) : null,
        leading: Navigator.canPop(context)
            ? IconButton(
                iconSize: 20,
                icon: Icon(LucideIcons.arrow_left),
                tooltip: "Ir atrás",
                onPressed: () => Navigator.pop(context),
              )
            : null,
        trailing: [
          ...?actions?.map((button) => Padding(padding: const EdgeInsets.only(right: 4), child: button)),
          IconButton(
            iconSize: 20,
            icon: Icon(LucideIcons.bell),
            tooltip: "Ver notificaciones",
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
        ],
      ),
    );
  }
}
