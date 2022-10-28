
import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/hobbies.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/data/repositories/storage_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit({
    required this.storage,
    required this.auth,
    required this.db,
  }) : super(ProfileInfoState(status: Status.initial()));
  final AuthRepository auth;
  final DataRepository db;
  final StorageRepository storage;

  String get id => auth.currentUser()!.uid;
  Hobbies hobbies = Hobbies();

  Future<void> saveData({required Map<String, dynamic> data}) async {
    emit(state.copyWith(status: Status.loading()));

    try {
      await db.setProfileFields(id, data);
      emit(state.copyWith(status: Status.loaded()));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> up(bool value) async {
    if (value) {
      value = false;
    } else {
      value = true;
    }

    emit(state.copyWith(
      status: Status.loaded(),
    ));
  }
}
