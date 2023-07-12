import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/data_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final DataRepository db;
  AuthCubit({required this.authRepository, required this.db}) : super(Initial()) {
    authRepository.auth.authStateChanges().listen((User? user) {
      initUser(user: user);

    });
  }

  Future<void> initUser({required User? user}) async {
    if (user == null) {
      emit(Unauthorized());
    } else {
      emit(Loading());
      UserModel? model = await db.getUserFields(user.uid);
      emit(Authorized(user: user,userModel: model));
      // emit(Authorized(user: user));
    }
  }
}
