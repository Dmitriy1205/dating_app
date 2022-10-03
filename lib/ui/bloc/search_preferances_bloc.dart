import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'search_preferances_state.dart';

class SearchPreferancesCubit extends Cubit<SearchPreferancesState> {
  SearchPreferancesCubit()
      : super(SearchPreferenceChangeState(age: RangeValues(17, 30), distance: 10, selectedLookingFor: []));
  RangeValues rangeAge = RangeValues(17, 30);
  int rangeDistance = 10;
  List<String> selectedLookingFor = [];
  Future<void> changeYears(RangeValues rangeValues) async {
    await {rangeAge = rangeValues};
    emit(SearchPreferenceChangeState(age: rangeAge, distance: rangeDistance, selectedLookingFor: selectedLookingFor));
  }
  Future<void> changeDistance(int newRangeDistance) async{
    rangeDistance = newRangeDistance;
    emit(SearchPreferenceChangeState(age: rangeAge, distance: rangeDistance, selectedLookingFor: selectedLookingFor));
  }
  Future<void> selectLookingFor (List<String> lookingFor)async {
    selectedLookingFor = lookingFor;
    emit(SearchPreferenceChangeState(age: rangeAge, distance: rangeDistance, selectedLookingFor: selectedLookingFor));
}

}


