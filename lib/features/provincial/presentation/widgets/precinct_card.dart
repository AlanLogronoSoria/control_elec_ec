/// Tarjeta de recinto para listados del Coordinador Provincial.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/app_database.dart';

class PrecinctCard extends StatelessWidget {
  const PrecinctCard({super.key, required this.precinct, this.onTap});

  final PrecinctsTableData precinct;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.provincialColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_city, color: AppColors.provincialColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(precinct.nombreRecinto,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('${precinct.provincia} › ${precinct.canton}',
                        style: const TextStyle(color: AppColors.textHint, fontSize: 13)),
                  ],
                ),
              ),
              Text('JRV: ${precinct.numeroJrv}',
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
