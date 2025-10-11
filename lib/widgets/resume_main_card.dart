import 'package:abejita/app_constant.dart';
import 'package:flutter/material.dart';

class ResumeMainCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String amount;
  final IconData icon;
  final double maxWidth;

  const ResumeMainCard({
    super.key,
    required this.title,
    required this.amount,
    this.subtitle,
    required this.icon,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 140, maxWidth: maxWidth),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: 8,
                children: [
                  Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
