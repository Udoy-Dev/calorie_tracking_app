import '../../domain/entities/food_item.dart';
import '../../domain/repositories/calorie_repository.dart';
import '../datasources/calorie_local_data_source.dart';
import '../models/food_item_model.dart';

class CalorieRepositoryImpl implements CalorieRepository {
  final CalorieLocalDataSource localDataSource;

  CalorieRepositoryImpl({required this.localDataSource});

  @override
  List<FoodItem> getFoodItems() {
    return localDataSource.getFoodItems();
  }

  @override
  void addFoodItem(FoodItem item) {
    final model = FoodItemModel.fromEntity(item);
    localDataSource.addFoodItem(model);
  }

  @override
  void deleteFoodItem(String id) {
    localDataSource.deleteFoodItem(id);
  }

  @override
  int getDailyGoal() {
    return localDataSource.getDailyGoal();
  }
}
