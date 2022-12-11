import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/status.dart';

class EditProfileState extends Equatable {
  final List<String>? selectedLookingForList;
  final Status? status;
  final SearchPrefFields? searchPref;
  final ProfileInfoFields? profileInfo;
  final UserModel? userModel;

  const EditProfileState({
    this.selectedLookingForList,
    this.status,
    this.searchPref,
    this.profileInfo,
    this.userModel,
  });

  @override
  List<Object?> get props => [
        selectedLookingForList,
        status,
        searchPref,
        profileInfo,
        userModel,
      ];

  EditProfileState copyWith({
    List<String>? selectedLookingForList,
    Status? status,
    SearchPrefFields? searchPref,
    ProfileInfoFields? profileInfo,
    UserModel? userModel,
  }) {
    return EditProfileState(
      selectedLookingForList:
          selectedLookingForList ?? this.selectedLookingForList,
      status: status ?? this.status,
      searchPref: searchPref ?? this.searchPref,
      profileInfo: profileInfo ?? this.profileInfo,
      userModel: userModel ?? this.userModel,
    );
  }
}
