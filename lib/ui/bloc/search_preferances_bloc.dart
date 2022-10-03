import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_preferances_event.dart';
part 'search_preferances_state.dart';

class SearchPreferancesBloc extends Bloc<SearchPreferancesEvent, SearchPreferancesState> {
  SearchPreferancesBloc() : super(SearchPreferancesInitial());

  @override
  Stream<SearchPreferancesState> mapEventToState(
    SearchPreferancesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
