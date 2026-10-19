import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/meal.dart';
import '../../../domain/repositories/meal_repository.dart';

abstract class MealEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMealsEvent extends MealEvent {
  final bool forceRemote;
  FetchMealsEvent({this.forceRemote = false});
  @override
  List<Object?> get props => [forceRemote];
}

abstract class MealState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealInitial extends MealState {}
class MealLoading extends MealState {}
class MealLoaded extends MealState {
  final List<Meal> meals;
  MealLoaded(this.meals);
  @override
  List<Object?> get props => [meals];
}
class MealError extends MealState {
  final String message;
  MealError(this.message);
  @override
  List<Object?> get props => [message];
}

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository mealRepository;

  MealBloc({required this.mealRepository}) : super(MealInitial()) {
    on<FetchMealsEvent>((event, emit) async {
      emit(MealLoading());
      try {
        final meals = await mealRepository.getMeals(forceRemote: event.forceRemote);
        emit(MealLoaded(meals));
      } catch (e) {
        emit(MealError("حدث خطأ أثناء تحميل الوجبات: ${e.toString()}"));
      }
    });
  }
}