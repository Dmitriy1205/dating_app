import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/data_repository.dart';

part 'friends_list_state.dart';

class FriendsListCubit extends Cubit<FriendsListState> {
  FriendsListCubit({
    required this.auth,
    required this.db,
  }) : super(FriendsListState(status: Status.initial())) {
    getFriendsList();
  }

  final AuthRepository auth;
  final DataRepository db;

  List<UserModel> usersList = [];

  Future<void> getFriendsList() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      usersList = await db.getContacts();
      emit(state.copyWith(status: Status.loaded(), usersList: usersList));
    } on Exception catch (e) {
      // TODO
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
