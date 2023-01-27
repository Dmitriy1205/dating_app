import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/data_repository.dart';

part 'blocked_contacts_state.dart';

class BlockedContactsCubit extends Cubit<BlockedContactsState> {
  BlockedContactsCubit({
    required this.auth,
    required this.db,
  }) : super(BlockedContactsState(status: Status.initial())) {
    getBlockedContacts();
  }

  final AuthRepository auth;
  final DataRepository db;
  List<UserModel> usersList = [];

  Future<void> getBlockedContacts() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      usersList = await db.getBlockedContacts();
      emit(state.copyWith(status: Status.loaded(), usersList: usersList));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> unblockContact(String id) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      await db.unblockContact(id).then((value) => getBlockedContacts());
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
