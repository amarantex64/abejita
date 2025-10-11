import 'package:abejita/app_constant.dart';
import 'package:abejita/app_theme.dart';
import 'package:abejita/routes.dart';
import 'package:abejita/services/navigation_service.dart';
import 'package:abejita/widgets/app_notification_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final String? title;
  final bool? extendBody;

  const MainLayout({super.key, required this.child, this.floatingActionButton, this.title, this.extendBody});

  @override
  Widget build(BuildContext context) {
    final isWide = AppScreen.isWide(context);
    final selectedIndex = NavigationService.indexOfRoute;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          spacing: 8,
          children: [
            Icon(LucideIcons.coins, size: 20, color: AppTheme.primaryColor),
            Text(title ?? AppConstant.projectName),
          ],
        ),
        titleTextStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
        animateColor: true,
        backgroundColor: AppTheme.secondaryColor,
        shadowColor: AppTheme.secondaryColor,
        scrolledUnderElevation: 8,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(LucideIcons.bell),
              iconSize: 16,
              style: ButtonStyle(
                iconColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(Colors.white.withAlpha(70)),
              ),
              tooltip: 'Ver notificaciones',
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
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
                          icon: r.tooltip != null
                              ? Tooltip(child: Icon(r.icon ?? Icons.apps))
                              : Icon(r.icon ?? Icons.apps),
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
