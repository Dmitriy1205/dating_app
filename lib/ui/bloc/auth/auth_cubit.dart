import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/core/exceptions.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState(status: Status.initial()));

  final AuthRepository authRepository;

  void getUser() {
    authRepository.authState;
  }

  Future<void> signUp({
    required String phoneNumber,
    required String verificationId,
    required void Function(String s) nav,
  }) async {
    emit(state.copyWith(status: Status.loading()));

    try {
      await authRepository.signupWithPhone(
        phoneNumber,
        verificationId,
        nav,
        load: () {
          emit(state.copyWith(status: Status.loading()));
        },
      );

      emit(state.copyWith(
        status: Status.loaded(),
      ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  Future<void> login({
    required String phoneNumber,
    required String verificationId,
    required void Function(String s) nav,
  }) async {
    try {
      emit(state.copyWith(status: Status.loading()));
      await authRepository.loginWithPhone(
        phoneNumber,
        verificationId,
        nav,
        loaded: () {
          emit(state.copyWith(status: Status.loaded()));
        },
      );
      FirebaseAuth.instance.authStateChanges();

      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
