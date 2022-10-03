import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_preferances_state.dart';

class SearchPreferancesBloc extends Cubit<SearchPreferancesState> {
  SearchPreferancesBloc() : super(SearchPreferenceChangeState(11, 21));

  double startYear = 14;
  double endYear = 25;

  Future <void> changeYears(RangeValues rangeValues) async {
    await {startYear = rangeValues.start};
    await {endYear = rangeValues.end};
    emit(SearchPreferenceChangeState(startYear, endYear));
    print('emitted');
  }
}
