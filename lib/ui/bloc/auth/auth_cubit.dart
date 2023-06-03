import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(Initial()) {
    authRepository.auth.authStateChanges().listen((User? user) {
      initUser(user: user);
    });
  }

  Future<void> initUser({required User? user}) async {
    if (user == null) {
      emit(Unauthorized());
    } else {
      emit(Authorized(user: user));
    }
  }
}
