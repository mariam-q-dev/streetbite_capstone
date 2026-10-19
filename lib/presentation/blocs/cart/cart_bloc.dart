import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/meal.dart';

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddMealToCart extends CartEvent {
  final Meal meal;
  AddMealToCart(this.meal);
  @override
  List<Object?> get props => [meal];
}

class RemoveMealFromCart extends CartEvent {
  final Meal meal;
  RemoveMealFromCart(this.meal);
  @override
  List<Object?> get props => [meal];
}

class ClearCart extends CartEvent {}

// State
class CartState extends Equatable {
  final List<Meal> items;
  final double totalPrice;

  const CartState({this.items = const [], this.totalPrice = 0.0});

  @override
  List<Object?> get props => [items, totalPrice];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddMealToCart>((event, emit) {
      final updatedList = List<Meal>.from(state.items)..add(event.meal);
      emit(CartState(items: updatedList, totalPrice: _calculateTotal(updatedList)));
    });

    on<RemoveMealFromCart>((event, emit) {
      final updatedList = List<Meal>.from(state.items)..remove(event.meal);
      emit(CartState(items: updatedList, totalPrice: _calculateTotal(updatedList)));
    });

    on<ClearCart>((event, emit) {
      emit(const CartState(items: [], totalPrice: 0.0));
    });
  }

  double _calculateTotal(List<Meal> items) {
    // افتراض سعر ثابت للوجبات 15.0 لغايات الحساب والتطوير
    return items.length * 15.0;
  }
}