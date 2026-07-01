/// Tarjeta de estadística reutilizable para dashboards.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.color = AppColors.primary,
    this.subtitle,
  });

  final String title;
  final String value;
  final IconData? icon;
  final Color color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(title, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!,
                  style: const TextStyle(color: AppColors.textHint, fontSize: 11)),
            ],
          ],
        ),
      ),
    );
  }
}
