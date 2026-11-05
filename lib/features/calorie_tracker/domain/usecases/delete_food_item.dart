import '../repositories/calorie_repository.dart';

class DeleteFoodItem {
  final CalorieRepository repository;

  DeleteFoodItem(this.repository);

  void call(String id) {
    repository.deleteFoodItem(id);
  }
}
