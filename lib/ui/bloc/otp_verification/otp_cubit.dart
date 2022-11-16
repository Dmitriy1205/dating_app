import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(OtpState(status: Status.initial()));
  final AuthRepository repository;

  Future<void> verifySignUp(
    String verId,
    String code,
    String name,
    String phone,
    String date,
    String email,
    String joinDate,
  ) async {
    await repository.verificationAfterSignUp(
      verId,
      code,
      name,
      phone,
      date,
      email,
      joinDate,
    );
    emit(state.copyWith(status: Status.loaded()));
  }

  Future<void> verifyLogin(
    String verId,
    String code,
  ) async {
    await repository.verificationAfterLogIn(
      verId,
      code,
    );
    emit(state.copyWith(status: Status.loaded()));
  }
}
