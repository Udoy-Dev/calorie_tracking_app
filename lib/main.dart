import 'package:flutter/material.dart';
import 'features/calorie_tracker/data/datasources/calorie_local_data_source.dart';
import 'features/calorie_tracker/data/repositories/calorie_repository_impl.dart';
import 'features/calorie_tracker/domain/usecases/add_food_item.dart';
import 'features/calorie_tracker/domain/usecases/delete_food_item.dart';
import 'features/calorie_tracker/domain/usecases/get_calorie_summary.dart';
import 'features/calorie_tracker/domain/usecases/get_food_items.dart';
import 'features/calorie_tracker/presentation/controllers/calorie_tracker_notifier.dart';
import 'features/calorie_tracker/presentation/pages/calorie_tracker_page.dart';

void main() {
  final notifier = createCalorieTrackerNotifier();
  runApp(CalorieTrackerApp(notifier: notifier));
}

CalorieTrackerNotifier createCalorieTrackerNotifier() {
  final localDataSource = CalorieLocalDataSourceImpl();
  final repository = CalorieRepositoryImpl(localDataSource: localDataSource);

  final getFoodItemsUseCase = GetFoodItems(repository);
  final addFoodItemUseCase = AddFoodItem(repository);
  final deleteFoodItemUseCase = DeleteFoodItem(repository);
  final getCalorieSummaryUseCase = GetCalorieSummary(repository);

  return CalorieTrackerNotifier(
    getFoodItemsUseCase: getFoodItemsUseCase,
    addFoodItemUseCase: addFoodItemUseCase,
    deleteFoodItemUseCase: deleteFoodItemUseCase,
    getCalorieSummaryUseCase: getCalorieSummaryUseCase,
  );
}

class CalorieTrackerApp extends StatelessWidget {
  final CalorieTrackerNotifier notifier;

  const CalorieTrackerApp({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: CalorieTrackerPage(notifier: notifier),
    );
  }
}
