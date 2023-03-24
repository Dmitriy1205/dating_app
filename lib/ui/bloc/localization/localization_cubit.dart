import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit({
    required this.db,
    required this.auth,
  }) : super(const LocalizationState(locale: Locale('en')));
  DataRepository db;
  AuthRepository auth;

  Future<void> init() async {
    final id = auth.currentUser()!.uid;
    final user = await db.getUserFields(id);
    String lang = user!.language!;
    emit(state.copyWith(locale: Locale(lang)));
  }

  void toEnglish() => emit(state.copyWith(locale: const Locale('en')));

  void toSpanish() => emit(state.copyWith(locale: const Locale('es')));

  void toFrench() => emit(state.copyWith(locale: const Locale('fr')));

  void toPortugal() => emit(state.copyWith(locale: const Locale('pt')));
}
