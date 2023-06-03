import 'package:bloc/bloc.dart';
import 'package:dating_app/core/exceptions.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(OtpState(status: Status.initial()));
  final AuthRepository repository;

  Future<void> verifySignUp({
    required String verId,
    required String code,
    required String name,
    required String phone,
    required String date,
    required String email,
    required String joinDate,
    required String language,
  }) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await repository.verificationAfterSignUp(
        verId: verId,
        date: date,
        code: code,
        name: name,
        phone: phone,
        email: email,
        joinDate: joinDate,
        language: language,
      );
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> verifyLogin(
    String verId,
    String code,
  ) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await repository.verificationAfterLogIn(
        verId,
        code,
      );
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
