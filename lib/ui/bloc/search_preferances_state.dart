part of 'search_preferances_bloc.dart';


abstract class SearchPreferancesState extends Equatable {}

class SearchPreferancesInitial extends SearchPreferancesState {
  @override
  List<Object?> get props => [];
}

class SearchPreferenceChangeState extends SearchPreferancesState {
   double? startYear;
   double? endYear;

  SearchPreferenceChangeState(startYear, endYear);
  @override
  List<Object?> get props => [startYear, endYear];
}