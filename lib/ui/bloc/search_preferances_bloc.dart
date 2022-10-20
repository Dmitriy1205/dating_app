import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_preferances_state.dart';

class SearchPreferancesCubit extends Cubit<SearchPreferancesState> {
  SearchPreferancesCubit()
      : super(SearchPreferenceChangeState(
      age: RangeValues(20, 30), distance: 28, selectedLookingFor: []));
  RangeValues rangeAge = RangeValues(20, 30);
  int rangeDistance = 28;
  List<String> selectedLookingFor = [];

  Future<void> changeYears(RangeValues rangeValues) async {
    await {rangeAge = rangeValues};
    emit(SearchPreferenceChangeState(
        age: rangeAge,
        distance: rangeDistance,
        selectedLookingFor: selectedLookingFor));
  }

  Future<void> changeDistance(int newRangeDistance) async {
    rangeDistance = newRangeDistance;
    emit(SearchPreferenceChangeState(
        age: rangeAge,
        distance: rangeDistance,
        selectedLookingFor: selectedLookingFor));
  }

  Future<void> selectLookingFor(String lookingFor) async {
    selectedLookingFor.add(lookingFor);
    print("added $selectedLookingFor");

    emit(SearchPreferenceChangeState(
        age: rangeAge,
        distance: rangeDistance,
        selectedLookingFor: selectedLookingFor));
  }

  Future<void> deSelectLookingFor(String lookingFor) async {
    selectedLookingFor.remove(lookingFor);
    print("removed $selectedLookingFor");
    emit(SearchPreferenceChangeState(
        age: rangeAge,
        distance: rangeDistance,
        selectedLookingFor: selectedLookingFor));
  }
}
