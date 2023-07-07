import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';
import '../connection/connection_cubit.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({
    required this.authRepository,
  }) : super(SignUpState(status: Status.initial()));

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
        loaded: () {
          emit(state.copyWith(status: Status.loaded()));
        },
      );

      // emit(state.copyWith(
      //   status: Status.loaded(),
      // ));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    } on Exception catch (_) {
      emit(state.copyWith(status: Status.initial()));
    }
  }

  Future<void> reset() async {
    emit(state.copyWith(status: Status.initial()));
  }
}
