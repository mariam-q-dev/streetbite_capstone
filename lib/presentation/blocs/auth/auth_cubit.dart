import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/remote/auth_remote_data_source.dart';
import '../../../data/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final UserModel user;
  Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}
class Unauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthCubit({required this.authRemoteDataSource}) : super(AuthInitial());

  void checkAuthState() {
    final user = authRemoteDataSource.getCurrentUser();
    if (user != null) {
      final userModel = UserModelBuilder()
          .setUid(user.uid)
          .setEmail(user.email ?? '')
          .setFullName(user.displayName ?? 'User')
          .build();
      emit(Authenticated(userModel));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRemoteDataSource.login(email: email, password: password);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    emit(AuthLoading());
    try {
      final user = await authRemoteDataSource.signUp(email: email, password: password, fullName: fullName);
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await authRemoteDataSource.logout();
    emit(Unauthenticated());
  }
}