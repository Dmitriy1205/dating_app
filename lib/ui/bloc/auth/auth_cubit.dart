import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(status: Status.initial()));
  final AuthRepository authRepository;

  Future<void> signUp({
    required String phoneNumber,
    required String verificationId,
    required Future<void> navigateTo,
  }) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository.signupWithPhone(
        phoneNumber,
        verificationId,
        navigateTo,
      );
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
