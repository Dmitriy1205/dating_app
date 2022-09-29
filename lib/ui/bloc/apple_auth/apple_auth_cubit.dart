import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apple_auth_state.dart';

class AppleAuthCubit extends Cubit<AppleAuthState> {
  AppleAuthCubit() : super(AppleAuthInitial());
}
