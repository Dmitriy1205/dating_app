import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/call_model.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../core/constants.dart';
import '../../data/models/status.dart';
import '../../data/repositories/data_repository.dart';
import '../../data/repositories/user_repository.dart';

class ContactsCubit extends Cubit<ContactsCubitStates> {
  final UserRepository _userRepository;
  final DataRepository _dataRepository;
  final AuthRepository _authRepository;

  ContactsCubit(
      {required AuthRepository authRepository,
      required UserRepository userRepository,
      required DataRepository dataRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        _dataRepository = dataRepository,
        super(ContactsCubitStates(status: Status.initial())) {
    updateConnections();
  }

  late UserModel palUser;

  List<UserModel> addedUsersList = [];
  List<UserModel> foundedNames = [];
  List<UserModel> userNames = [];

  Future<String> getUrlImage(String id) async {
    final String image = await _dataRepository.getUserFields(id).then((value) {
      return value!.profileInfo!.image!;
    });
    return image;
  }

  Future<void> updateConnections() async {
    addedUsersList = await _dataRepository.getContacts(currentUserId: _authRepository.currentUser()!.uid);
    final currentUserFields = await _dataRepository.getUserFields(_authRepository.currentUser()!.uid);

    final List<CallModel> callHistoryList = await _userRepository.getUserCallHistory();
    callHistoryList.removeWhere((element) => element.callerId != _authRepository.currentUser()!.uid );

    for (var i = 0; i < addedUsersList.length; i++) {
      List<String> userMatch =
          await _dataRepository.isUserMatch(addedUsersList[i].id.toString());
      if (!userMatch.contains(_authRepository.currentUser()!.uid) ||
          userMatch.contains(null)) {
        addedUsersList.removeAt(i);
        i--;
      }
      // if (usersList[i].id == authRepository.currentUser()!.uid) {
      //   usersList.removeAt(i);
      // }
    }

    emit(
      state.copyWith(
        usersList: addedUsersList,
        status: Status.loaded(),
        search: Search.finishSearch,
        currentUserAvatar: currentUserFields!.profileInfo?.image,
        currentUserId: currentUserFields.id,
        currentUserName: currentUserFields.firstName,
        callHistory: callHistoryList,
      ),
    );
  }

  Future<void> searchContact(String name) async {
    emit(state.copyWith(search: Search.searching));
    try {
      addedUsersList = await _dataRepository.getContacts(currentUserId: _authRepository.currentUser()!.uid);
      for (var i = 0; i < addedUsersList.length; i++) {
        List<String> userMatch =
            await _dataRepository.isUserMatch(addedUsersList[i].id.toString());
        if (!userMatch.contains(_authRepository.currentUser()!.uid) ||
            userMatch.contains(null)) {
          addedUsersList.removeAt(i);
          i--;
        }
        // if (usersList[i].id == authRepository.currentUser()!.uid) {
        //   usersList.removeAt(i);
        // }
      }
      userNames = List.generate(
          addedUsersList.length, (index) => addedUsersList[index]);

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
  final bool? userMatch;
  final Search? search;
  final List<UserModel>? foundedUsersList;
  final List<CallModel>? callHistory;

  const ContactsCubitStates({
    this.image,
    this.usersList,
    this.status,
    this.currentUserAvatar,
    this.currentUserId,
    this.currentUserName,
    this.userBlocked = false,
    this.userMatch,
    this.search,
    this.foundedUsersList,
    this.callHistory,
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
        userMatch,
        search,
        foundedUsersList,
    callHistory,
      ];

  ContactsCubitStates copyWith({
    List<String>? image,
    List<UserModel>? usersList,
    Status? status,
    String? currentUserAvatar,
    String? currentUserId,
    String? currentUserName,
    bool? userBlocked,
    bool? userMatch,
    Search? search,
    List<UserModel>? foundedUsersList,
    List<CallModel>? callHistory,
  }) {
    return ContactsCubitStates(
      image: image ?? this.image,
      usersList: usersList ?? this.usersList,
      status: status ?? this.status,
      currentUserAvatar: currentUserAvatar ?? this.currentUserAvatar,
      currentUserId: currentUserId ?? this.currentUserId,
      currentUserName: currentUserName ?? this.currentUserName,
      userBlocked: userBlocked ?? this.userBlocked,
      userMatch: userMatch ?? this.userMatch,
      search: search ?? this.search,
      foundedUsersList: foundedUsersList ?? this.foundedUsersList,
      callHistory: callHistory ?? this.callHistory,
    );
  }
}
