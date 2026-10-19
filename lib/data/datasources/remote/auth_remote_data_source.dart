import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp({required String email, required String password, required String fullName});
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  User? getCurrentUser() => firebaseAuth.currentUser;

  @override
  Future<UserModel> signUp({required String email, required String password, required String fullName}) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = credential.user!.uid;

    final userModel = UserModelBuilder()
        .setUid(uid)
        .setFullName(fullName)
        .setEmail(email)
        .build();

    await firestore.collection('users').doc(uid).set(userModel.toMap());
    return userModel;
  }

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final uid = credential.user!.uid;

    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      return UserModelBuilder()
          .setUid(uid)
          .setEmail(email)
          .setFullName('User')
          .build();
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}