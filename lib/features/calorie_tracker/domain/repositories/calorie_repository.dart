import '../entities/food_item.dart';

abstract class CalorieRepository {
  List<FoodItem> getFoodItems();
  void addFoodItem(FoodItem item);
  void deleteFoodItem(String id);
  int getDailyGoal();
}
