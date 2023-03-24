import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'facebook_auth_state.dart';

class FacebookAuthCubit extends Cubit<FacebookAuthState> {
  final AuthRepository _repository;

  FacebookAuthCubit(this._repository)
      : super(FacebookAuthState(status: Status.initial()));

  Future<void> login() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await _repository.loginWithFacebook();
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }
}
