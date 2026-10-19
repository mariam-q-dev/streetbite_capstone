import 'package:cloud_firestore/cloud_firestore.dart';

/// Singleton Pattern Implementation for Firestore Service
class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Private constructor
  FirestoreService._internal();

  // Factory constructor returning the same instance
  factory FirestoreService() {
    return _instance;
  }

  // Save placed order
  Future<void> saveOrder(String userId, Map<String, dynamic> orderData) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .add(orderData);
  }

  // Toggle Favourite Meal
  Future<void> toggleFavourite(String userId, Map<String, dynamic> mealData) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .doc(mealData['idMeal']);

    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set(mealData);
    }
  }

  // Get User Favourites Stream
  Stream<QuerySnapshot> getFavouritesStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favourites')
        .snapshots();
  }

  // Get User Orders Stream
  Stream<QuerySnapshot> getOrdersStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}