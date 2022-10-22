import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_preferances_state.dart';

class SearchPreferancesCubit extends Cubit<SearchPreferancesState> {
  SearchPreferancesCubit()
      : super(SearchPreferenceChangeState(
            age: RangeValues(20, 30), distance: 28));
  RangeValues rangeAge = RangeValues(20, 30);
  int rangeDistance = 28;

  Future<void> changeYears(RangeValues rangeValues) async {
    await {rangeAge = rangeValues};
    emit(SearchPreferenceChangeState(
      age: rangeAge,
      distance: rangeDistance,
    ));
  }

  Future<void> changeDistance(int newRangeDistance) async {
    rangeDistance = newRangeDistance;
    emit(SearchPreferenceChangeState(
      age: rangeAge,
      distance: rangeDistance,
    ));
  }
}
