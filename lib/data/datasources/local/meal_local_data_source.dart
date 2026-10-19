import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/meal_model.dart';

abstract class MealLocalDataSource {
  Future<void> cacheMeals(List<MealModel> meals);
  Future<List<MealModel>> getCachedMeals();
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String cachedMealsKey = 'CACHED_MEALS';

  MealLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheMeals(List<MealModel> meals) async {
    final jsonList = meals.map((m) => m.toJson()).toList();
    await sharedPreferences.setString(cachedMealsKey, jsonEncode(jsonList));
  }

  @override
  Future<List<MealModel>> getCachedMeals() async {
    final jsonString = sharedPreferences.getString(cachedMealsKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((item) => MealModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }
}