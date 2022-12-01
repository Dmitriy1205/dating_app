import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/data/repositories/storage_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/exceptions.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.auth,
    required this.db,
    required this.storage,
  }) : super(ProfileState()) {
    // getData();
    init();
  }

  final AuthRepository auth;
  final DataRepository db;
  final StorageRepository storage;

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));

    try {
      final id = auth.currentUser()!.uid;
      final user = await db.getUserFields(id);
      final image = await storage.getAllById(id);
      emit(state.copyWith(
        status: Status.loaded(),
        user: user,
        images: image,
      ));
    } on BadRequestException catch (e) {
      print(e.message);
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  // Future<void> getData() async {
  //   emit(state.copyWith(status: Status.loading()));
  //
  //   try {
  //     final id = auth.currentUser()!.uid;
  //     final profile = await db.getProfileFields(id);
  //     final user = await db.getUserFields(id);
  //     final search = await db.getSearchFields(id);
  //     final image = await storage.getAllById(id);
  //     emit(state.copyWith(
  //       status: Status.loaded(),
  //       profile: profile,
  //       user: user,
  //       images: image,
  //       lookingFor: search?.lookingFor,
  //     ));
  //   } on BadRequestException catch (e) {
  //     print(e.message);
  //     emit(state.copyWith(status: Status.error(e.message)));
  //   }
  // }
}
