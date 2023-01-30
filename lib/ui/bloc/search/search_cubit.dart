import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(status: Status.initial()));

  void search(bool isSearch) => emit(state.copyWith(isSearching: isSearch));
}
