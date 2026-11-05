import '../entities/food_item.dart';
import '../repositories/calorie_repository.dart';

class GetFoodItems {
  final CalorieRepository repository;

  GetFoodItems(this.repository);

  List<FoodItem> call() {
    return repository.getFoodItems();
  }
}
