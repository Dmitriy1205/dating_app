import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/ui/bloc/search_preferances_state.dart';
import 'package:flutter/material.dart';

import '../../data/models/status.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/data_repository.dart';

class SearchPreferencesCubit extends Cubit<SearchPreferencesState> {
  final DataRepository db;
  final AuthRepository auth;
  SearchPrefFields searchData = SearchPrefFields();

  SearchPreferencesCubit({
    required this.auth,
    required this.db,
  }) : super(SearchPreferencesState(
          status: Status.initial(),
          age: const RangeValues(20, 30),
          distance: 28,
          selectedLookingForList: [],
        ));

  List<String> selectedLookingForList = [];

  Future<void> setLookingForFields(String selectedLookingFor) async {
    selectedLookingForList.contains(selectedLookingFor)
        ? selectedLookingForList.remove(selectedLookingFor)
        : selectedLookingForList.add(selectedLookingFor);
    emit(state.copyWith(
        status: Status.loading(),
        selectedLookingForList: selectedLookingForList));
  }

  Future<void> setAge(RangeValues rangeValues) async =>
      emit(state.copyWith(age: rangeValues));

  Future<void> setDistance(int distance) async =>
      emit(state.copyWith(distance: distance));

  Future<void> saveData({required SearchPrefFields data}) async {
    var id = auth.currentUser()!.uid;
    searchData.distance = data.distance;
    searchData.yearsRange = data.yearsRange;
    searchData.lookingFor = data.lookingFor;
    searchData.gender = data.gender;
    searchData.id = id;

    await db.setSearchFields(id, searchData.toFirestore());
    emit(state.copyWith(status: Status.loaded()));
  }
}
