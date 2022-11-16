import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/storage_repository.dart';

part 'personal_profile_state.dart';

class PersonalProfileCubit extends Cubit<PersonalProfileState> {
  PersonalProfileCubit(this.storage)
      : super(PersonalProfileState(status: Status.initial()));
  final StorageRepository storage;

  Future<void> getPics(String id) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final im = await storage.getAllById(id);
      emit(state.copyWith(
        status: Status.loaded(),
        pic: im,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: Status.error(),
      ));
    }
  }
}
