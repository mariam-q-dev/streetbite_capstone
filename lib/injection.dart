import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/datasources/remote/firestore_service.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/meal/meal_bloc.dart';

import 'data/datasources/local/meal_local_data_source.dart';
import 'data/datasources/remote/meal_remote_data_source.dart';
import 'data/datasources/remote/auth_remote_data_source.dart';
import 'data/repositories/meal_repository_impl.dart';
import 'domain/repositories/meal_repository.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'core/theme/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // External Services
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  sl.registerLazySingleton(() => FirestoreService());
  sl.registerFactory(() => CartBloc());
  sl.registerFactory(() => MealBloc(mealRepository: sl()));

  // Data Sources
  sl.registerLazySingleton<MealLocalDataSource>(
    () => MealLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<MealRemoteDataSource>(
    () => MealRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );

  // Repositories & Factory
  sl.registerLazySingleton(() => MealDataSourceFactory(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(dataSourceFactory: sl()),
  );

  // Cubits & Blocs
  sl.registerFactory(() => ThemeCubit(sharedPreferences: sl()));
  sl.registerFactory(() => AuthCubit(authRemoteDataSource: sl()));
}