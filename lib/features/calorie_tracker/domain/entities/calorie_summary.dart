class CalorieSummary {
  final int totalCalories;
  final int dailyGoal;

  const CalorieSummary({
    required this.totalCalories,
    required this.dailyGoal,
  });

  int get remainingCalories => dailyGoal - totalCalories;
  bool get isOverGoal => remainingCalories < 0;
}
