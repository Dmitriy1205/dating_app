import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/storage_repository.dart';

import '../../core/exceptions.dart';
import '../../data/models/status.dart';
import '../../data/repositories/data_repository.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required this.auth,
    required this.storage,
    required this.db,
  }) : super(const EditProfileState(
          selectedLookingForList: [],
        )) {
    // getFields();
    init();
  }

  final AuthRepository auth;
  final StorageRepository storage;
  final DataRepository db;
  List<String> selectedLookingForList = [];

  String get id => auth.currentUser()!.uid;

  Future<void> changeData(String selectedLookingFor) async {
    selectedLookingForList.contains(selectedLookingFor)
        ? selectedLookingForList.remove(selectedLookingFor)
        : selectedLookingForList.add(selectedLookingFor);
    print('lookingFor from EditProfileCubit $selectedLookingForList');

    emit(state.copyWith(
        status: Status.initial(),
        selectedLookingForList: selectedLookingForList));
  }

  Future<void> init() async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    try {
      final userField = await db.getUserFields(id);

      emit(state.copyWith(
        status: Status.loaded(),
        userModel: userField,
      ));
    } on BadRequestException catch (e) {
      print(e.message);
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

  Future<void> update(ProfileInfoFields p, Map<String,dynamic> s,String name) async {
    try {
      await db.updateFields(id, p.toFirestore(), s,name);
      emit(state.copyWith(status: Status.loaded()));
    } on BadRequestException catch (e) {
      print('prof edit $e');
      print(e.message);
      emit(state.copyWith(status: Status.error(e.message)));
    }
  }

// Future<void> getFields() async {
//   emit(state.copyWith(
//     status: Status.loading(),
//   ));
//   try {
//     final sField = await db.getSearchFields(id);
//     final inField = await db.getProfileFields(id);
//
//     emit(state.copyWith(
//       status: Status.loaded(),
//       searchPref: sField,
//       profileInfo: inField,
//     ));
//   } on BadRequestException catch (e) {
//     print(e.message);
//     emit(state.copyWith(status: Status.error(e.message)));
//   }
// }

// Future<void> updateFields(ProfileInfoFields p, SearchPrefFields s) async {
//   try {
//     await db.updateProfileFields(id, p.toFirestore());
//     await db.updateSearchFields(id, s.toFirestore());
//     emit(state.copyWith(status: Status.loaded()));
//   } on BadRequestException catch (e) {
//     print('prof edit $e');
//     print(e.message);
//     emit(state.copyWith(status: Status.error(e.message)));
//   }
// }
}
