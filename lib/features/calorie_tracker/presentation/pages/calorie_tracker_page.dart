import 'package:flutter/material.dart';
import '../../domain/entities/food_item.dart';
import '../controllers/calorie_tracker_notifier.dart';
import '../widgets/add_food_dialog.dart';
import '../widgets/calorie_summary_card.dart';
import '../widgets/food_list.dart';

class CalorieTrackerPage extends StatelessWidget {
  final CalorieTrackerNotifier notifier;

  const CalorieTrackerPage({
    super.key,
    required this.notifier,
  });

  String get _formattedTodayDate {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final dayName = days[now.weekday - 1];
    final monthName = months[now.month - 1];
    return '$dayName, $monthName ${now.day}, ${now.year}';
  }

  void _openAddFoodDialog(BuildContext context) {
    AddFoodDialog.show(context, (FoodItem item) {
      notifier.addFood(item);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} (${item.calories} kcal) added!'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  void _deleteFoodItem(BuildContext context, String id) {
    final deletedItem = notifier.foodItems.firstWhere((item) => item.id == id);
    notifier.deleteFood(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedItem.name} removed'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        final summary = notifier.summary;
        final foodItems = notifier.foodItems;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Calorie Tracker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Add Food',
                onPressed: () => _openAddFoodDialog(context),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Date Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formattedTodayDate,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                // Calorie Summary Cards
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: CalorieSummarySection(summary: summary),
                ),
                const SizedBox(height: 8),
                // Section Title & Add Food Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's Meals",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _openAddFoodDialog(context),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Add Food'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(indent: 16, endIndent: 16),
                // Food List
                Expanded(
                  child: FoodList(
                    foodItems: foodItems,
                    onDeleteFood: (id) => _deleteFoodItem(context, id),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openAddFoodDialog(context),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add Food'),
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
