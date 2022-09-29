import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'facebook_auth_state.dart';

class FacebookAuthCubit extends Cubit<FacebookAuthState> {
  FacebookAuthCubit() : super(FacebookAuthInitial());
}
