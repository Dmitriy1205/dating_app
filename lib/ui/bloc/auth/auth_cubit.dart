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
    required void Function(String s) nav,
  }) async {
    emit(state.copyWith(status: Status.loading()));
    print('print 1 AuthCubit $verificationId');

    try {
      await authRepository.signupWithPhone(
        phoneNumber,
        verificationId,
        nav,
      );
      print('print 2 AuthCubit $verificationId');
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
  Future<void> login({
    required String phoneNumber,
    required String verificationId,
    required void Function(String s) nav,
  }) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository.loginWithPhone(
        phoneNumber,
        verificationId,
        nav,
      );
      print('print 3 AuthCubit $verificationId');
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
