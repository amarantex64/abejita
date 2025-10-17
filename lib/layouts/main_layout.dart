import 'package:abejita/app_constant.dart';
import 'package:abejita/routes.dart';
import 'package:abejita/services/navigation_service.dart';
import 'package:abejita/widgets/app_bar_search.dart';
import 'package:abejita/widgets/app_notification_drawer.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final String? title;
  final bool? extendBody;
  final bool preventFocusOnSearchTap;
  final List<IconButton>? actions;
  final PreferredSizeWidget? appBar;
  final Color? appBarBackground;
  final TextInputType? keyboardTypeSearch;
  final ValueChanged<String>? onSearchChanged, onSearchSubmitted;
  final GestureTapCallback? onSearchTap;
  final TapRegionCallback? onSearchTapOutside;

  const MainLayout({
    super.key,
    this.appBar,
    this.actions,
    required this.child,
    this.floatingActionButton,
    this.title,
    this.extendBody,
    this.appBarBackground,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSearchTapOutside,
    this.onSearchTap,
    this.keyboardTypeSearch,
    this.preventFocusOnSearchTap = false
  });

  @override
  Widget build(BuildContext context) {
    final isWide = AppScreen.isWide(context);
    final selectedIndex = NavigationService.indexOfRoute;

    return Scaffold(
      appBar:
          appBar ??
          AppBarSearch(
            actions: actions,
            onTap: onSearchTap,
            title: title ?? "Búsqueda",
            onChanged: onSearchChanged,
            onSubmitted: onSearchSubmitted,
            onTapOutside: onSearchTapOutside,
            keyboardType: keyboardTypeSearch,
            backgroundColor: appBarBackground,
            preventFocusOnTap: preventFocusOnSearchTap,
          ),
      endDrawer: AppNotificationDrawer(),
      floatingActionButton: floatingActionButton,
      extendBody: extendBody ?? true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: !isWide
          ? child
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: NavigationService.navigateTo,
                  labelType: NavigationRailLabelType.all,
                  destinations: appPagesRoutes
                      .map(
                        (r) => NavigationRailDestination(
                          icon: r.tooltip != null ? Tooltip(child: Icon(r.icon ?? Icons.apps)) : Icon(r.icon ?? Icons.apps),
                          label: Text(r.title ?? ""),
                          disabled: r.disabled ?? false,
                          indicatorColor: r.indicatorColor ?? r.iconColor,
                          selectedIcon: r.selectedIcon != null ? Icon(r.selectedIcon) : null,
                        ),
                      )
                      .toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            ),
      bottomNavigationBar: isWide
          ? null
          : BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: NavigationService.navigateTo,
              items: appPagesRoutes
                  .map(
                    (r) => BottomNavigationBarItem(
                      key: key,
                      icon: Icon(r.icon ?? Icons.apps),
                      label: r.title ?? "",
                      backgroundColor: r.indicatorColor ?? r.iconColor,
                      activeIcon: r.selectedIcon != null ? Icon(r.selectedIcon) : null,
                      tooltip: r.tooltip ?? r.title,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
