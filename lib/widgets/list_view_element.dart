import 'package:abejita/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ListViewElement extends StatelessWidget {
  final String? avatarUrl, subtitle, footer;
  final String title;
  final bool showTitleOnly, enable;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final List<ListTile>? modalBottomSheetOptions;

  const ListViewElement({
    super.key,
    required this.title,
    this.avatarUrl,
    this.subtitle,
    this.footer,
    this.enable = true,
    this.showTitleOnly = false,
    this.onTap,
    this.onLongPress,
    this.modalBottomSheetOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
      child: ListTile(
        enabled: enable,
        isThreeLine: footer != null,
        shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null ? Icon(LucideIcons.user) : null,
        ),
        title: Text(title, maxLines: 1, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.titleMedium),
        subtitle: showTitleOnly
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null) Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                  if (footer != null) Text(footer!, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
        onTap: onTap,
        onLongPress: () {
          if (onLongPress != null) {
            onLongPress!();
          }
          if (modalBottomSheetOptions != null) {
            showModalBottomSheet(
              context: context,
              useSafeArea: true,
              elevation: 2,
              showDragHandle: true,
              builder: (context) => Column(mainAxisSize: MainAxisSize.min, children: modalBottomSheetOptions!),
            );
          }
        },
      ),
    );
  }
}
