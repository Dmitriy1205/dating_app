import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'conference_state.dart';

class ConferenceCubit extends Cubit<ConferenceState> {
  ConferenceCubit() : super(ConferenceInitial());
}
