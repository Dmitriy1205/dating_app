part of 'search_preferances_bloc.dart';


abstract class SearchPreferancesState extends Equatable {}

class SearchPreferancesInitial extends SearchPreferancesState {
  @override
  List<Object?> get props => [];
}

class SearchPreferenceChangeState extends SearchPreferancesState {
   RangeValues age = RangeValues(18, 29);
   int distance = 5;
   List selectedLookingFor = [];
  SearchPreferenceChangeState({required this.age, required this.distance, required this.selectedLookingFor});
  @override
  List<Object?> get props => [age, distance, selectedLookingFor];


}