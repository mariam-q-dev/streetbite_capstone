import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../../data/datasources/remote/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// SOLID Principle: Payment Interface
abstract class PaymentStrategy {
  Future<void> processPayment(double amount);
}

class CashPayment implements PaymentStrategy {
  @override
  Future<void> processPayment(double amount) async {
    // معالجة الدفع النقدي عند الاستلام
    await Future.delayed(const Duration(seconds: 1));
  }
}

class CardPayment implements PaymentStrategy {
  @override
  Future<void> processPayment(double amount) async {
    // معالجة الدفع الإلكتروني بالبطاقة
    await Future.delayed(const Duration(seconds: 1));
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.items.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Your cart is now empty')),
            );
          }
        },
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Cart is empty', style: TextStyle(fontSize: 18)));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final meal = state.items[index];
                    return ListTile(
                      leading: Image.network(meal.thumbUrl, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(meal.name),
                      subtitle: Text('\$15.0'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<CartBloc>().add(RemoveMealFromCart(meal));
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Price:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${state.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        onPressed: () async {
                          PaymentStrategy payment = CashPayment(); // يمكن التبديل بـ CardPayment
                          await payment.processPayment(state.totalPrice);

                          if (userId.isNotEmpty) {
                            await firestoreService.saveOrder(userId, {
                              'items': state.items.map((m) => m.name).toList(),
                              'total': state.totalPrice,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                          }

                          if (context.mounted) {
                            context.read<CartBloc>().add(ClearCart());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed successfully!')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Checkout Order', style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}