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
    // getData();
    sl<UserRepository>().userLoginRepo();
    sl<UserRepository>().loggedUserPictureMethod();
    init();
  }

  final DataRepository db;
  final AuthRepository auth;

  Future<void> init() async {
    emit(state.copyWith(
      status: Status.loading(),
    ));
    try {

      final id = auth.currentUser()!.uid;
      final searchUser = await db.getUserFields(id);
      final allUsers = await db.getAllUserFields();

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

      List<UserModel> filtered = [];
      for (var i = 0; i < allUsers.length; i++) {
        for (int a = 0; a < searchUser!.searchPref!.interests!.length; a++) {
          if (searchUser.searchPref!.interests!.values.elementAt(a)) {
            if (allUsers[i].profileInfo!.interests!.values !=
                searchUser.searchPref!.interests!.values) {
              filtered.add(allUsers[i]);
              print('---------- ${allUsers[i].firstName}');
              // allUsers.removeWhere((element) => element.id == allUsers[i].id);
            }

          }
        }
      }
      for (var i = 0; i < allUsers.length; i++) {
        for (int a = 0; a < searchUser!.searchPref!.hobbies!.length; a++) {
          if (searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
            if (allUsers[i].profileInfo!.hobbies!.values.elementAt(a) ==
                searchUser!.searchPref!.hobbies!.values.elementAt(a)) {
              filtered.add(allUsers[i]);
            }
          }
        }
      }

      for (var i = 0; i < allUsers.length; i++) {
        for (int a = 0; a < searchUser!.searchPref!.lookingFor!.length; a++) {
          if (searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
            if (allUsers[i].searchPref!.lookingFor!.values.elementAt(a) ==
                searchUser!.searchPref!.lookingFor!.values.elementAt(a)) {
              filtered.add(allUsers[i]);
            }
          }
        }
      }
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
        user: allUsers,
      ));
    } on Exception catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: Status.error(),
      ));
    }
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
