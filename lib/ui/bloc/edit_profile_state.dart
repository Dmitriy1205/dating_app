import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/status.dart';

class EditProfileState extends Equatable {
  final List<String>? selectedLookingForList;
  final Status? status;
  final SearchPrefFields? search;
  final ProfileInfoFields? info;

  const EditProfileState({
    this.selectedLookingForList,
    this.status,
    this.search,
    this.info,
  });

  @override
  List<Object?> get props => [
        selectedLookingForList,
        status,
        search,
        info,
      ];

  EditProfileState copyWith({
    List<String>? selectedLookingForList,
    Status? status,
    SearchPrefFields? search,
    ProfileInfoFields? info,
  }) {
    return EditProfileState(
      selectedLookingForList:
          selectedLookingForList ?? this.selectedLookingForList,
      status: status ?? this.status,
      search: search ?? this.search,
      info: info ?? this.info,
    );
  }
}
