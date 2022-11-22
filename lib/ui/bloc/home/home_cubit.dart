import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/search_pref_data.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.db,
    required this.auth,
  }) : super(HomeState(
          status: Status.initial(),
        )) {
    getData();
  }

  final DataRepository db;
  final AuthRepository auth;

  Future<void> getData() async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    try {
      final id = auth.currentUser()!.uid;
      final fields = await db.getAllFields();
      final lookingFor = await db.getAllSearchFields();
      final users = await db.getAllUserFields();
      final searchUser = await db.getSearchFields(id);

      users.removeWhere((element) => element.id == id);
      lookingFor
        ..removeWhere((element) => element.id == id)
        ..removeWhere((element) => element.distance! > searchUser!.distance!);
      fields
        ..removeWhere((element) => element.id == id)
        ..removeWhere((element) =>
            int.parse(element.age!) <
                searchUser?.yearsRange?.values.elementAt(0) ||
            int.parse(element.age!) >
                searchUser?.yearsRange?.values.elementAt(1))
        ..removeWhere((element) => element.gender != searchUser?.gender);

      emit(state.copyWith(
        status: Status.loaded(),
        fields: fields,
        lookingFor: lookingFor,
        user: users,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: Status.error(),
      ));
    }
  }
}
