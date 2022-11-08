import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/status.dart';

class SearchPreferencesState extends Equatable {
  final Status? status;
  final RangeValues? age;
  final int? distance;
  final List<String>? selectedLookingForList;

  const SearchPreferencesState({
    this.status,
    this.age,
    this.distance,
    this.selectedLookingForList,
  });

  @override
  List<Object?> get props => [
        status,
        age,
        distance,
        selectedLookingForList,
      ];

  SearchPreferencesState copyWith({
    Status? status,
    RangeValues? age,
    int? distance,
    List<String>? selectedLookingForList,
  }) {
    return SearchPreferencesState(
      status: status ?? this.status,
      age: age ?? this.age,
      distance: distance ?? this.distance,
      selectedLookingForList:
          selectedLookingForList ?? this.selectedLookingForList,
    );
  }
}
