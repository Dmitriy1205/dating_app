import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/status.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit({
    required this.db,
    required this.auth,
  }) : super(FilterState()) {
    // getData();
    init();
  }

  final DataRepository db;
  final AuthRepository auth;

  String get id => auth.currentUser()!.uid;

  void setAge(RangeValues rangeValues) async =>
      emit(state.copyWith(age: rangeValues));

  void setGender(String gender) async => emit(state.copyWith(gender: gender));

  void setDistance(int distance) async =>
      emit(state.copyWith(distance: distance));
  List<String> selectedLookingForList = [];
  List<String> selectedHobbieList = [];
  List<String> selectedInterestList = [];

  Future<void> setLookingForFields(String lookingFor) async {
    selectedLookingForList.contains(lookingFor)
        ? selectedLookingForList.remove(lookingFor)
        : selectedLookingForList.add(lookingFor);
    emit(state.copyWith(
      status: Status.initial(),
      loFor: selectedLookingForList,
    ));
  }

  Future<void> setHobbieFields(String hobb) async {
    selectedHobbieList.contains(hobb)
        ? selectedHobbieList.remove(hobb)
        : selectedHobbieList.add(hobb);
    emit(state.copyWith(
      status: Status.initial(),
      hob: selectedHobbieList,
    ));
  }

  Future<void> setInterestFields(String inter) async {
    print('inter $inter');
    selectedInterestList.contains(inter)
        ? selectedInterestList.remove(inter)
        : selectedInterestList.add(inter);
    emit(state.copyWith(
      status: Status.initial(),
      inter: selectedInterestList,
    ));
  }

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final user = await db.getUserFields(id);
      final searchPref = user!.searchPref!;

      int start = searchPref.yearsRange!.values.elementAt(0);
      int end = searchPref.yearsRange!.values.elementAt(1);
      print('start: $start, end: $end');
      final yearsRange = RangeValues(start.toDouble(), end.toDouble());
      emit(state.copyWith(
        status: Status.loaded(),
        age: yearsRange,
        gender: searchPref.gender,
        searchFields: searchPref,
        lookingFor: searchPref.lookingFor,
        distance: searchPref.distance,
        hobbies: searchPref.hobbies,
        interests: searchPref.interests,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> saveFilter(SearchPrefFields s) async {
    try {
      await db.updateSearchFields(id, s.toFirestore());
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
// Future<void> getData() async {
//   emit(state.copyWith(status: Status.loading()));
//   try {
//     final fields = await db.getSearchFields(id);
//     int start = fields!.yearsRange!.values.elementAt(0);
//     int end = fields.yearsRange!.values.elementAt(1);
//     print('start: $start, end: $end');
//     final yearsRange = RangeValues(start.toDouble(), end.toDouble());
//     emit(state.copyWith(
//       status: Status.loaded(),
//       age: yearsRange,
//       gender: fields.gender,
//       searchFields: fields,
//       lookingFor: fields.lookingFor,
//       distance: fields.distance,
//       hobbies: fields.hobbies,
//       interests: fields.interests,
//     ));
//   } on Exception catch (e) {
//     print(e.toString());
//     emit(state.copyWith(status: Status.error(e.toString())));
//   }
// }
}
