part of 'search_preferances_bloc.dart';

abstract class SearchPreferancesState extends Equatable {}

class SearchPreferancesInitial extends SearchPreferancesState {
  @override
  List<Object?> get props => [];
}

class SearchPreferenceChangeState extends SearchPreferancesState {
  RangeValues age;
  int distance;

  late List<String> selectedLookingForList;

  SearchPreferenceChangeState(
      {required this.age,
      required this.distance,
        required this.selectedLookingForList
      });

  @override
  List<Object?> get props => [double.nan];
}
