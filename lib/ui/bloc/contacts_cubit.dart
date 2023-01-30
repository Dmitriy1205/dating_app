import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../core/constants.dart';
import '../../core/service_locator.dart';
import '../../data/models/status.dart';
import '../../data/repositories/data_repository.dart';

class ContactsCubit extends Cubit<ContactsCubitStates> {
  ContactsCubit({required this.authRepository})
      : super(ContactsCubitStates(status: Status.initial())) {
    updateConnections();
  }

  late UserModel palUser;
  DataRepository db = sl();
  final AuthRepository authRepository;

  List<UserModel> usersList = [];
  List<UserModel> foundedNames = [];
  List<UserModel> userNames = [];

  Future<String> getUrlImage(String id) async {
    final String image = await db.getUserFields(id).then((value) {
      return value!.profileInfo!.image!;
    });
    return image;
  }

  Future<void> updateConnections() async {
    usersList = await db.getContacts();
    final u = await db.getUserFields(authRepository.currentUser()!.uid);
    for (int i = 0; i < usersList.length; i++) {
      print('${usersList[i].firstName}');
      if (usersList[i].id == authRepository.currentUser()!.uid) {
        print('delete ${usersList[i].firstName}');
        usersList.removeAt(i);
      }
      // imagesList.add(await getUrlImage(usersList[i].id!));
    }
    emit(state.copyWith(
      usersList: usersList,
      status: Status.loaded(),
      search: Search.finishSearch,
      // image: imagesList,
      currentUserAvatar: u!.profileInfo?.image,
      currentUserId: u.id,
      currentUserName: u.firstName,
    ));
  }

  Future<void> searchContact(String name) async {
    emit(state.copyWith(search: Search.searching));
    try {
      usersList = await db.getContacts();
      userNames = List.generate(usersList.length, (index) => usersList[index]);

      if (name.isEmpty) {
        emit(state.copyWith(search: Search.found, foundedUsersList: userNames));
      } else {
        foundedNames = userNames
            .where((user) =>
                user.firstName!.toLowerCase().contains(name.toLowerCase()))
            .toList();
        if (foundedNames.isEmpty) {
          emit(state.copyWith(
            search: Search.noMatch,
          ));
        } else {
          emit(state.copyWith(
            search: Search.found,
            foundedUsersList: foundedNames,
          ));
        }
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}

class ContactsCubitStates extends Equatable {
  final List<String>? image;
  final List<UserModel>? usersList;
  final Status? status;
  final String? currentUserId;
  final String? currentUserName;
  final String? currentUserAvatar;
  final bool? userBlocked;
  final Search? search;
  final List<UserModel>? foundedUsersList;

  const ContactsCubitStates({
    this.image,
    this.usersList,
    this.status,
    this.currentUserAvatar,
    this.currentUserId,
    this.currentUserName,
    this.userBlocked = false,
    this.search,
    this.foundedUsersList,
  });

  @override
  List<Object?> get props => [
        image,
        usersList,
        status,
        currentUserAvatar,
        currentUserId,
        currentUserName,
        userBlocked,
        search,
        foundedUsersList,
      ];

  ContactsCubitStates copyWith({
    List<String>? image,
    List<UserModel>? usersList,
    Status? status,
    String? currentUserAvatar,
    String? currentUserId,
    String? currentUserName,
    bool? userBlocked,
    Search? search,
    List<UserModel>? foundedUsersList,
  }) {
    return ContactsCubitStates(
      image: image ?? this.image,
      usersList: usersList ?? this.usersList,
      status: status ?? this.status,
      currentUserAvatar: currentUserAvatar ?? this.currentUserAvatar,
      currentUserId: currentUserId ?? this.currentUserId,
      currentUserName: currentUserName ?? this.currentUserName,
      userBlocked: userBlocked ?? this.userBlocked,
      search: search ?? this.search,
      foundedUsersList: foundedUsersList ?? this.foundedUsersList,
    );
  }
}
