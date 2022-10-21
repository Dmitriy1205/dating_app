import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.repository) : super(OtpState(status: Status.initial()));
  final AuthRepository repository;

  Future<void> verify(String verId, String code) async {
    await repository.loginWithPhone(verId, code);
    emit(state.copyWith(status: Status.loaded()));
  }
}
