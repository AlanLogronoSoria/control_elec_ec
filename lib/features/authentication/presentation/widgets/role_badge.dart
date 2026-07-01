/// Badge visual para mostrar el rol de un usuario.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/user_entity.dart';

class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.rol});

  final UserRole rol;

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    String label;

    switch (rol) {
      case UserRole.coordinadorProvincial:
        color = AppColors.provincialColor;
        icon = Icons.account_balance;
        label = 'Coord. Provincial';
      case UserRole.coordinadorRecinto:
        color = AppColors.recintoColor;
        icon = Icons.location_city;
        label = 'Coord. Recinto';
      case UserRole.veedorMesa:
        color = AppColors.veedorColor;
        icon = Icons.how_to_vote;
        label = 'Veedor';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
