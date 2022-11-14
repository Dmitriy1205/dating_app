import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/search_pref_data.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.db,
  }) : super(HomeState(
          status: Status.initial(),
        )) {
    getData();
  }

  final DataRepository db;

  Future<void> getData() async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    try {
      final fields = await db.getAllFields();
      final lookingFor = await db.getAllSearchFields();
      final user = await db.getAllUserFields();

      emit(state.copyWith(
        status: Status.loaded(),
        fields: fields,
        lookingFor: lookingFor,
        user: user,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: Status.error(),
      ));
    }
  }
}
