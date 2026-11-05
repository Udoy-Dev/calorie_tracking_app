import '../entities/food_item.dart';
import '../repositories/calorie_repository.dart';

class AddFoodItem {
  final CalorieRepository repository;

  AddFoodItem(this.repository);

  void call(FoodItem item) {
    repository.addFoodItem(item);
  }
}
