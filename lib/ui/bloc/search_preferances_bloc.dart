import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'search_preferances_state.dart';

class SearchPreferancesCubit extends Cubit<SearchPreferancesState> {
  SearchPreferancesCubit()
      : super(SearchPreferenceChangeState(RangeValues(17, 30)));
  RangeValues rangeAge = RangeValues(17, 30);
  Future<void> changeYears(RangeValues rangeValues) async {
    await {rangeAge = rangeValues};
    emit(SearchPreferenceChangeState(rangeAge));
    print('emitted');
  }
}
