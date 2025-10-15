import 'package:flutter/material.dart';

class NofoundElement extends StatelessWidget {
  final IconData icon;
  final String? title;

  const NofoundElement({required this.icon, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: Colors.grey),
        const SizedBox(height: 8),
        Text(
          title ?? "No se encontraron resultados",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
        ),
      ],
    );
  }
}
