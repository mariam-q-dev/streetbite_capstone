import '../../domain/entities/meal.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/local/meal_local_data_source.dart';
import '../datasources/remote/meal_remote_data_source.dart';

/// Factory Pattern Implementation to select DataSource strategy
class MealDataSourceFactory {
  final MealRemoteDataSource remoteDataSource;
  final MealLocalDataSource localDataSource;

  MealDataSourceFactory({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<Meal>> fetch({required bool forceRemote}) async {
    if (forceRemote) {
      final remoteMeals = await remoteDataSource.fetchMeals('a');
      await localDataSource.cacheMeals(remoteMeals);
      return remoteMeals;
    } else {
      final cached = await localDataSource.getCachedMeals();
      if (cached.isNotEmpty) {
        return cached;
      } else {
        final remoteMeals = await remoteDataSource.fetchMeals('a');
        await localDataSource.cacheMeals(remoteMeals);
        return remoteMeals;
      }
    }
  }
}

class MealRepositoryImpl implements MealRepository {
  final MealDataSourceFactory dataSourceFactory;

  MealRepositoryImpl({required this.dataSourceFactory});

  @override
  Future<List<Meal>> getMeals({bool forceRemote = false}) async {
    return await dataSourceFactory.fetch(forceRemote: forceRemote);
  }
}