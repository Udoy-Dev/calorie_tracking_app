import 'package:flutter/material.dart';
import '../../domain/entities/calorie_summary.dart';

class CalorieSummarySection extends StatelessWidget {
  final CalorieSummary summary;

  const CalorieSummarySection({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Total Calories',
            value: '${summary.totalCalories}',
            unit: 'kcal',
            icon: Icons.local_fire_department_rounded,
            color: Colors.orange.shade700,
            backgroundColor: Colors.orange.shade50,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCard(
            title: 'Daily Goal',
            value: '${summary.dailyGoal}',
            unit: 'kcal',
            icon: Icons.flag_rounded,
            color: Colors.blue.shade700,
            backgroundColor: Colors.blue.shade50,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCard(
            title: 'Remaining',
            value: '${summary.remainingCalories}',
            unit: 'kcal',
            icon: summary.isOverGoal
                ? Icons.warning_amber_rounded
                : Icons.pie_chart_rounded,
            color: summary.isOverGoal
                ? Colors.red.shade700
                : Colors.green.shade700,
            backgroundColor: summary.isOverGoal
                ? Colors.red.shade50
                : Colors.green.shade50,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Text(
              unit,
              style: TextStyle(
                fontSize: 12,
                color: color.withValues(alpha: 0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
