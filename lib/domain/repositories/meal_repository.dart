import '../entities/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getMeals({bool forceRemote = false});
}