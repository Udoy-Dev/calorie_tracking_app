import '../models/food_item_model.dart';

abstract class CalorieLocalDataSource {
  List<FoodItemModel> getFoodItems();
  void addFoodItem(FoodItemModel item);
  void deleteFoodItem(String id);
  int getDailyGoal();
}

class CalorieLocalDataSourceImpl implements CalorieLocalDataSource {
  final List<FoodItemModel> _items = [];
  final int _dailyGoal = 2000;

  @override
  List<FoodItemModel> getFoodItems() {
    return List.unmodifiable(_items);
  }

  @override
  void addFoodItem(FoodItemModel item) {
    _items.add(item);
  }

  @override
  void deleteFoodItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  @override
  int getDailyGoal() {
    return _dailyGoal;
  }
}
