part of 'search_preferances_bloc.dart';


abstract class SearchPreferancesState extends Equatable {}

class SearchPreferancesInitial extends SearchPreferancesState {
  @override
  List<Object?> get props => [];
}

class SearchPreferenceChangeState extends SearchPreferancesState {
   RangeValues age;

  SearchPreferenceChangeState(this.age);
  @override
  List<Object?> get props => [age];
}