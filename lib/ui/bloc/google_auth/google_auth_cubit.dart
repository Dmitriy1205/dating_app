import 'package:bloc/bloc.dart';
import 'package:dating_app/core/exceptions.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final AuthRepository authRepository;

  GoogleAuthCubit(this.authRepository)
      : super(GoogleAuthState(status: Status.initial()));

  Future<void> login() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await authRepository.loginWithGoogle();
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      emit(state.copyWith(status: Status.error(e.message)));
      print('class GoogleAuthCubit ${e.message}');
    }
  }
}
