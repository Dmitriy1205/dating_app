import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;

  SignInCubit({
    required this.authRepository,
  }) : super(SignInState(status: Status.initial()));

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
        loaded: () {
          emit(state.copyWith(status: Status.loaded()));
        },
      );

      // emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> reset() async {
    emit(state.copyWith(status: Status.loaded()));
  }

}
