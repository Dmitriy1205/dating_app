import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions.dart';
import '../../../data/repositories/auth_repository.dart';

part 'apple_auth_state.dart';

class AppleAuthCubit extends Cubit<AppleAuthState> {
  final AuthRepository _repository;

  AppleAuthCubit(this._repository)
      : super(AppleAuthState(status: Status.initial()));

  Future<void> login() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await _repository.loginWithApple();
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      print(e.message);
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
