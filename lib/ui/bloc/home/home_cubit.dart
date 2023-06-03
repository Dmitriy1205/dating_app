import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/service_locator.dart';
import '../../../data/models/search_pref_data.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.db,
    required this.auth,
  }) : super(HomeState(
          status: Status.initial(),
        )) {
    UserRepository userRepository = sl<UserRepository>();
    userRepository.userLoginRepo();
    userRepository.loggedUserPictureMethod();
    init();
  }

  final DataRepository db;
  final AuthRepository auth;

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    init();
  }

  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));

    try {
      final currentUserId = auth.currentUser()!.uid;
      final searchUser = await db.getUserFields(currentUserId);
      final allUsers = await db.getPals(currentUserId: currentUserId);

      print('===========${allUsers[0].firstName}');

       List<UserModel> filtered = allUsers.where((user) {
        return
          user.id != currentUserId
              &&
            user.searchPref != null &&
            user.searchPref!.distance! <= searchUser!.searchPref!.distance! &&
            int.parse(user.profileInfo!.age!) >=
                searchUser.searchPref!.yearsRange!.entries
                    .firstWhere((entry) => entry.key == 'start')
                    .value &&
            int.parse(user.profileInfo!.age!) <=
                searchUser.searchPref!.yearsRange!.entries
                    .firstWhere((entry) => entry.key == 'end')
                    .value &&
            user.profileInfo!.gender == searchUser.searchPref!.gender;
      }).toList();

      print('===========${filtered}');

      // filtered.removeWhere((user) {
      //   final interests = searchUser!.searchPref!.interests!.entries
      //       .where((entry) => entry.value);
      //   final hobbies = searchUser.searchPref!.hobbies!.entries
      //       .where((entry) => entry.value);
      //   final lookingFor = searchUser.searchPref!.lookingFor!.entries
      //       .where((entry) => entry.value);
      //
      //   return !interests.every(
      //           (interest) => user.searchPref!.interests![interest.key]) ||
      //       !hobbies.every((hobby) => user.searchPref!.hobbies![hobby.key]) ||
      //       !lookingFor.every(
      //           (lookingFor) => user.searchPref!.lookingFor![lookingFor.key]);
      // });
      print('===========${filtered}');

      emit(state.copyWith(status: Status.loaded(), user: filtered));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error(e.toString()),
      ));
    }
  }

  Future<void> addUser(String id) async {
    db.dataProvider.addedToFriends(id, currentUserId: auth.currentUser()!.uid);
    try {
      List<String> userMatch = await db.isUserMatch(id);
      UserModel? matchUser = await db.getUserFields(id);
      UserModel? currentUser = await db.getUserFields(auth.currentUser()!.uid);
      if (userMatch.contains(auth.currentUser()!.uid)) {
        emit(state.copyWith(
          match: true,
          matchUser: matchUser,
          currentUser: currentUser,
        ));
      } else {
        emit(state.copyWith(match: false));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  void refuseUser(String id) {
    db.dataProvider.refusedFriends(id, currentUserId: auth.currentUser()!.uid);
  }
}
