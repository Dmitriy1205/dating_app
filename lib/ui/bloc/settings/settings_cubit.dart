import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.auth) : super(const SettingsState());
  final AuthRepository auth;

  Future<void> logout() async {
    await auth.logout();
  }
}
