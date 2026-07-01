/// Widget de gráfico de progreso usando fl_chart.
library;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({
    super.key,
    required this.completadas,
    required this.pendientes,
    this.height = 180,
  });

  final int completadas;
  final int pendientes;
  final double height;

  @override
  Widget build(BuildContext context) {
    final total = completadas + pendientes;
    final pctCompletado = total == 0 ? 0.0 : completadas / total;

    return SizedBox(
      height: height,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: pctCompletado * 100,
              color: AppColors.success,
              title: '${(pctCompletado * 100).toStringAsFixed(0)}%',
              radius: 50,
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            PieChartSectionData(
              value: (1 - pctCompletado) * 100,
              color: AppColors.warningLight.withOpacity(0.5),
              title: '${pendientes}',
              radius: 40,
              titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
