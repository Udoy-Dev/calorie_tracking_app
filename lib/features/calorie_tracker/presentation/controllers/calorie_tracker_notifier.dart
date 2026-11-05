import 'package:flutter/foundation.dart';
import '../../domain/entities/calorie_summary.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/usecases/add_food_item.dart';
import '../../domain/usecases/delete_food_item.dart';
import '../../domain/usecases/get_calorie_summary.dart';
import '../../domain/usecases/get_food_items.dart';

class CalorieTrackerNotifier extends ChangeNotifier {
  final GetFoodItems getFoodItemsUseCase;
  final AddFoodItem addFoodItemUseCase;
  final DeleteFoodItem deleteFoodItemUseCase;
  final GetCalorieSummary getCalorieSummaryUseCase;

  CalorieTrackerNotifier({
    required this.getFoodItemsUseCase,
    required this.addFoodItemUseCase,
    required this.deleteFoodItemUseCase,
    required this.getCalorieSummaryUseCase,
  });

  List<FoodItem> get foodItems => getFoodItemsUseCase();

  CalorieSummary get summary => getCalorieSummaryUseCase();

  void addFood(FoodItem item) {
    addFoodItemUseCase(item);
    notifyListeners();
  }

  void deleteFood(String id) {
    deleteFoodItemUseCase(id);
    notifyListeners();
  }
}
