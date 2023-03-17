import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../core/service_locator.dart';
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

  // Future<void> init() async {
  //   emit(state.copyWith(
  //     status: Status.loading(),
  //   ));
  //   List<UserModel> filtered = [];
  //   List<UserModel> filteredInterests = [];
  //   List<UserModel> filteredHobbies = [];
  //   List<UserModel> filteredLookingFor = [];
  //
  //   try {
  //     final id = auth.currentUser()!.uid;
  //     final UserModel? searchUser = await db.getUserFields(id);
  //     final List<UserModel> allUsers = await db.getPals();
  //     allUsers
  //       ..removeWhere((element) => element.id == id)
  //       ..removeWhere((element) => element.searchPref == null)
  //       ..removeWhere((element) =>
  //           element.searchPref!.distance! > searchUser!.searchPref!.distance! )
  //       ..removeWhere((element) =>
  //           int.parse(element.profileInfo!.age!) <
  //               searchUser?.searchPref!.yearsRange?.values.elementAt(0) ||
  //           int.parse(element.profileInfo!.age!) >
  //               searchUser?.searchPref!.yearsRange?.values.elementAt(1))
  //       ..removeWhere((element) =>
  //           element.profileInfo!.gender != searchUser?.searchPref!.gender);
  //     print('allUsers ${allUsers.length}');
  //
  //     for (int a = 0; a < searchUser!.searchPref!.interests!.length; a++) {
  //       if (searchUser.searchPref!.interests!.values.elementAt(a)) {
  //         for (var user in allUsers) {
  //           bool boolInUser = user.searchPref!.interests![
  //               searchUser.searchPref!.interests!.keys.elementAt(a)];
  //           if (boolInUser) {
  //             print(' added interests ${user.firstName}');
  //             filteredInterests.contains(user)
  //                 ? null
  //                 : filteredInterests.add(user);
  //             // allUsers.removeWhere((element) => element.id == allUsers[i].id);
  //           }
  //         }
  //       }
  //     }
  //     for (int a = 0; a < searchUser!.searchPref!.hobbies!.length; a++) {
  //       if (searchUser.searchPref!.hobbies!.values.elementAt(a)) {
  //         for (var user in allUsers) {
  //           bool boolInUser = user.searchPref!
  //               .hobbies![searchUser.searchPref!.hobbies!.keys.elementAt(a)];
  //           if (boolInUser) {
  //             print(' added hobbies ${user.firstName}');
  //             filteredHobbies.contains(user) ? null : filteredHobbies.add(user);
  //             print('filteredLookingFor ${filteredHobbies.first}');
  //             // allUsers.removeWhere((element) => element.id == allUsers[i].id);
  //           }
  //         }
  //       }
  //     }
  //
  //     for (int a = 0; a < searchUser!.searchPref!.lookingFor!.length; a++) {
  //       if (searchUser.searchPref!.lookingFor!.values.elementAt(a)) {
  //         for (var user in allUsers) {
  //           bool boolInUser = user.searchPref!.lookingFor![
  //               searchUser.searchPref!.lookingFor!.keys.elementAt(a)];
  //           if (boolInUser) {
  //             print(' added lookingFor ${user.firstName}');
  //
  //             filteredLookingFor.contains(user)
  //                 ? null
  //                 : filteredLookingFor.add(user);
  //             print('filteredLookingFor ${filteredLookingFor.first}');
  //             // allUsers.removeWhere((element) => element.id == allUsers[i].id);
  //           }
  //         }
  //       }
  //     }
  //     List<UserModel> partiallyfiltered = [];
  //     filteredInterests.forEach((element) {
  //       filteredHobbies.contains(element)
  //           ? partiallyfiltered.add(element)
  //           : null;
  //     });
  //     partiallyfiltered.forEach((element) {
  //       filteredLookingFor.contains(element) ? filtered.add(element) : null;
  //     });
  //     if (filtered.isNotEmpty) {
  //       // for (var i = 0; i < allUsers.length; i++) {
  //       //   for (int a = 0; a < searchUser!.searchPref!.hobbies!.length; a++) {
  //       //     if (searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
  //       //       if (allUsers[i].profileInfo!.hobbies!.values.elementAt(a) ==
  //       //           searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
  //       //         filtered.add(allUsers[i]);
  //       //       }
  //       //     }
  //       //   }
  //       // }
  //
  //       // for (var i = 0; i < allUsers.length; i++) {
  //       //   for (int a = 0; a < searchUser!.searchPref!.lookingFor!.length; a++) {
  //       //     if (searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
  //       //       if (allUsers[i].searchPref!.lookingFor!.values.elementAt(a) ==
  //       //           searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
  //       //         filtered.add(allUsers[i]);
  //       //       }
  //       //     }
  //       //   }
  //       // }
  //
  //       // print(lookingFor.length);
  //       // for (var i = 0; i < lookingFor.length; i++) {
  //       //   print(lookingFor.map((e) => e.id).toList());
  //       //   print('----------------');
  //       //   print(allProfileFields.map((e) => e.id).toList());
  //       //   if (lookingFor[i].id != allProfileFields[i].id) {
  //       //     lookingFor.removeWhere((element) => element.id == allProfileFields[i].id);
  //       //
  //       //     print(lookingFor[i].id);
  //       //   }
  //       //
  //       //   red.add(lookingFor[i]);
  //       // }
  //
  //       emit(state.copyWith(
  //         status: Status.loaded(),
  //         // fields: filtered,
  //         // lookingFor: red,
  //         user: filtered,
  //       ));
  //     } else {
  //       emit(state.copyWith(status: Status.error()));
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     emit(state.copyWith(
  //       status: Status.error(),
  //     ));
  //   }
  // }
  Future<void> init() async {
    emit(state.copyWith(status: Status.loading()));

    try {
      final id = auth.currentUser()!.uid;
      final searchUser = await db.getUserFields(id);
      final allUsers = await db.getPals();
      print('userlist from homeCubit() allUsers---${allUsers.length} users');
      print(
          'searchUser from homeCubit() searchUser---${searchUser!.searchPref!.gender} users');

      final filtered = allUsers.where((user) {
        return user.id != id &&
            user.searchPref != null &&
            user.searchPref!.distance! <= searchUser.searchPref!.distance! &&
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

      filtered.removeWhere((user) {
        final interests = searchUser.searchPref!.interests!.entries
            .where((entry) => entry.value);
        final hobbies = searchUser.searchPref!.hobbies!.entries
            .where((entry) => entry.value);
        final lookingFor = searchUser.searchPref!.lookingFor!.entries
            .where((entry) => entry.value);

        return !interests.every(
                (interest) => user.searchPref!.interests![interest.key]) ||
            !hobbies.every((hobby) => user.searchPref!.hobbies![hobby.key]) ||
            !lookingFor.every(
                (lookingFor) => user.searchPref!.lookingFor![lookingFor.key]);
      });

      emit(state.copyWith(status: Status.loaded(), user: filtered));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error(e.toString()),
      ));
    }
  }

  Future<void> addUser(String id) async {
    db.dataProvider.addedToFriends(id);
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
    db.dataProvider.refusedFriends(id);
    print('refusedFriend id $id');
  }
}
