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

    // getData();
    init();
  }

  final DataRepository db;
  final AuthRepository auth;

  Future<void> init() async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    List<UserModel> filtered = [];
    List<UserModel> filteredInterests = [];
    List<UserModel> filteredHobbies = [];
    List<UserModel> filteredLookingFor = [];

    try {
      final id = auth.currentUser()!.uid;
      final UserModel? searchUser = await db.getUserFields(id);
      final List<UserModel> allUsers = await db.getPals();
      for (var user in allUsers) {
        print(
            'allUsers ${user.searchPref!.interests} ${user.searchPref!.hobbies} ${user.searchPref!.lookingFor} ${user.id} ${user.firstName}');
      }
      print(
          'searchUser ${searchUser!.searchPref?.interests} ${searchUser!.searchPref?.hobbies} ${searchUser!.searchPref?.lookingFor}');
      allUsers
        ..removeWhere((element) => element.id == id)
        ..removeWhere((element) =>
            element.searchPref!.distance! > searchUser!.searchPref!.distance!)
        ..removeWhere((element) =>
            int.parse(element.profileInfo!.age!) <
                searchUser?.searchPref!.yearsRange?.values.elementAt(0) ||
            int.parse(element.profileInfo!.age!) >
                searchUser?.searchPref!.yearsRange?.values.elementAt(1))
        ..removeWhere((element) =>
            element.profileInfo!.gender != searchUser?.searchPref!.gender);
      print('allUsers ${allUsers.length}');

      for (int a = 0; a < searchUser!.searchPref!.interests!.length; a++) {
        if (searchUser.searchPref!.interests!.values.elementAt(a)) {
          for (var user in allUsers) {
            bool boolInUser = user.searchPref!.interests![
                searchUser.searchPref!.interests!.keys.elementAt(a)];
            if (boolInUser) {
              print(' added interests ${user.firstName}');
              filteredInterests.contains(user)
                  ? null
                  : filteredInterests.add(user);
              // allUsers.removeWhere((element) => element.id == allUsers[i].id);
            }
          }
        }
      }
      for (int a = 0; a < searchUser!.searchPref!.hobbies!.length; a++) {
        if (searchUser.searchPref!.hobbies!.values.elementAt(a)) {
          for (var user in allUsers) {
            bool boolInUser = user.searchPref!
                .hobbies![searchUser.searchPref!.hobbies!.keys.elementAt(a)];
            if (boolInUser) {
              print(' added hobbies ${user.firstName}');
              filteredHobbies.contains(user) ? null : filteredHobbies.add(user);
              print('filteredLookingFor ${filteredHobbies.first}');
              // allUsers.removeWhere((element) => element.id == allUsers[i].id);
            }
          }
        }
      }

      for (int a = 0; a < searchUser!.searchPref!.lookingFor!.length; a++) {
        if (searchUser.searchPref!.lookingFor!.values.elementAt(a)) {
          for (var user in allUsers) {
            bool boolInUser = user.searchPref!.lookingFor![
                searchUser.searchPref!.lookingFor!.keys.elementAt(a)];
            if (boolInUser) {
              print(' added lookingFor ${user.firstName}');

              filteredLookingFor.contains(user)
                  ? null
                  : filteredLookingFor.add(user);
              print('filteredLookingFor ${filteredLookingFor.first}');
              // allUsers.removeWhere((element) => element.id == allUsers[i].id);
            }
          }
        }
      }
      List<UserModel> partiallyfiltered = [];
      filteredInterests.forEach((element) {
        filteredHobbies.contains(element)
            ? partiallyfiltered.add(element)
            : null;
      });
      partiallyfiltered.forEach((element) {
        filteredLookingFor.contains(element) ? filtered.add(element) : null;
      });


      // for (var i = 0; i < allUsers.length; i++) {
      //   for (int a = 0; a < searchUser!.searchPref!.hobbies!.length; a++) {
      //     if (searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
      //       if (allUsers[i].profileInfo!.hobbies!.values.elementAt(a) ==
      //           searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
      //         filtered.add(allUsers[i]);
      //       }
      //     }
      //   }
      // }

      // for (var i = 0; i < allUsers.length; i++) {
      //   for (int a = 0; a < searchUser!.searchPref!.lookingFor!.length; a++) {
      //     if (searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
      //       if (allUsers[i].searchPref!.lookingFor!.values.elementAt(a) ==
      //           searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
      //         filtered.add(allUsers[i]);
      //       }
      //     }
      //   }
      // }

      // print(lookingFor.length);
      // for (var i = 0; i < lookingFor.length; i++) {
      //   print(lookingFor.map((e) => e.id).toList());
      //   print('----------------');
      //   print(allProfileFields.map((e) => e.id).toList());
      //   if (lookingFor[i].id != allProfileFields[i].id) {
      //     lookingFor.removeWhere((element) => element.id == allProfileFields[i].id);
      //
      //     print(lookingFor[i].id);
      //   }
      //
      //   red.add(lookingFor[i]);
      // }

      emit(state.copyWith(
        status: Status.loaded(),
        // fields: filtered,
        // lookingFor: red,
        user: filtered,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: Status.error(),
      ));
    }
  }




  void addUser(String id){
    db.dataProvider.addedToFriends(id);
    print('addUser id $id');
  }
  void refuseUser(String id){
    db.dataProvider.refusedFriends(id);
    print('refusedFriend id $id');
  }
// Future<void> getData() async {
//   emit(state.copyWith(
//     status: Status.loading(),
//   ));
//   try {
//     final id = auth.currentUser()!.uid;
//     var allProfileFields = await db.getAllFields();
//     final lookingFor = await db.getAllSearchFields();
//     final allUsers = await db.getAllUserFields();
//     final searchUser = await db.getSearchFields(id);
//     // final us = allProfileFields.map((e) => e.id);
//
//     allUsers.removeWhere((element) => element.id == id);
//     lookingFor
//       // ..removeWhere((element) => element.id == id)
//       ..removeWhere((element) => element.distance! > searchUser!.distance!);
//     allProfileFields
//       // ..removeWhere((element) => element.id == id)
//       ..removeWhere((element) =>
//           int.parse(element.age!) <
//               searchUser?.yearsRange?.values.elementAt(0) ||
//           int.parse(element.age!) >
//               searchUser?.yearsRange?.values.elementAt(1))
//       ..removeWhere((element) => element.gender != searchUser?.gender);
//
//     List<ProfileInfoFields> filtered = [];
//     for (var i = 0; i < allProfileFields.length; i++) {
//       for (int a = 0; a < searchUser!.interests!.length; a++) {
//         if (searchUser!.interests!.values.elementAt(a)) {
//           if (allProfileFields[i].interests!.values.elementAt(a) !=
//               searchUser!.interests!.values.elementAt(a)) {
//             filtered.add(allProfileFields[i]);
//           }
//         }
//       }
//     }
//     for (var i = 0; i < allProfileFields.length; i++) {
//       for (int a = 0; a < searchUser!.hobbies!.length; a++) {
//         if (searchUser!.hobbies!.values.elementAt(a)) {
//           if (allProfileFields[i].hobbies!.values.elementAt(a) !=
//               searchUser!.hobbies!.values.elementAt(a)) {
//             filtered.add(allProfileFields[i]);
//           }
//         }
//       }
//     }
//     List<SearchPrefFields> red = [];
//     for (var i = 0; i < lookingFor.length; i++) {
//       for (int a = 0; a < searchUser!.lookingFor!.length; a++) {
//         if (searchUser!.lookingFor!.values.elementAt(a)) {
//           if (lookingFor[i].lookingFor!.values.elementAt(a) !=
//               searchUser!.lookingFor!.values.elementAt(a)) {
//             red.add(lookingFor[i]);
//           }
//         }
//       }
//     }
//     // print(lookingFor.length);
//     // for (var i = 0; i < lookingFor.length; i++) {
//     //   print(lookingFor.map((e) => e.id).toList());
//     //   print('----------------');
//     //   print(allProfileFields.map((e) => e.id).toList());
//     //   if (lookingFor[i].id != allProfileFields[i].id) {
//     //     lookingFor.removeWhere((element) => element.id == allProfileFields[i].id);
//     //
//     //     print(lookingFor[i].id);
//     //   }
//     //
//     //   red.add(lookingFor[i]);
//     // }
//
//     emit(state.copyWith(
//       status: Status.loaded(),
//       fields: filtered,
//       lookingFor: red,
//       user: allUsers,
//     ));
//   } on Exception catch (e) {
//     print(e.toString());
//     emit(state.copyWith(
//       status: Status.error(),
//     ));
//   }
// }
}
