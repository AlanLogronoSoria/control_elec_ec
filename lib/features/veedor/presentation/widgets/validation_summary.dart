/// Widget de resumen y validación de la sumatoria de votos.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ValidationSummary extends StatelessWidget {
  const ValidationSummary({
    super.key,
    required this.totalVotosCandidatos,
    required this.votosBlancos,
    required this.votosNulos,
    required this.totalSufragantes,
  });

  final int totalVotosCandidatos;
  final int votosBlancos;
  final int votosNulos;
  final int totalSufragantes;

  bool get _isValid =>
      (totalVotosCandidatos + votosBlancos + votosNulos) == totalSufragantes;

  int get _sumaTotal => totalVotosCandidatos + votosBlancos + votosNulos;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isValid ? AppColors.success.withOpacity(0.08) : AppColors.danger.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isValid ? Icons.check_circle : Icons.warning,
                  color: _isValid ? AppColors.success : AppColors.danger,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _isValid ? 'Sumatoria correcta' : 'Sumatoria incorrecta',
                  style: TextStyle(
                    color: _isValid ? AppColors.success : AppColors.danger,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _row('Votos candidatos', totalVotosCandidatos),
            _row('Votos blancos', votosBlancos),
            _row('Votos nulos', votosNulos),
            const Divider(height: 16),
            _row('Suma total', _sumaTotal,
                bold: true, color: _isValid ? AppColors.success : AppColors.danger),
            _row('Total sufragantes', totalSufragantes, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, int value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text('$value', style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color)),
        ],
      ),
    );
  }
}
