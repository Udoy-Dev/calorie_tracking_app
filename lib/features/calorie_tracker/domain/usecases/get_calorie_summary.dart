import '../entities/calorie_summary.dart';
import '../repositories/calorie_repository.dart';

class GetCalorieSummary {
  final CalorieRepository repository;

  GetCalorieSummary(this.repository);

  CalorieSummary call() {
    final items = repository.getFoodItems();
    final totalCalories = items.fold(0, (sum, item) => sum + item.calories);
    final dailyGoal = repository.getDailyGoal();

    return CalorieSummary(
      totalCalories: totalCalories,
      dailyGoal: dailyGoal,
    );
  }
}
