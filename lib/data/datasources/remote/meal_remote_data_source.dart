import 'package:dio/dio.dart';
import '../../models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<MealModel>> fetchMeals(String query);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?s=';

  MealRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealModel>> fetchMeals(String query) async {
    final response = await dio.get('$baseUrl$query');
    if (response.statusCode == 200 && response.data['meals'] != null) {
      final List mealsJson = response.data['meals'];
      return mealsJson.map((json) => MealModel.fromJson(json)).toList();
    }
    return [];
  }
}