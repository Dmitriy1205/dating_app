part of 'profile_info_cubit.dart';

class ProfileInfoState extends Equatable {
  final Status? status;
  final Hobbies? hobbies;
  // final ProfileInfoData? data;

  const ProfileInfoState({
     this.hobbies,
    this.status,
  });

  @override
  List<Object?> get props => [
        status,
        hobbies,
      ];

  ProfileInfoState copyWith({
    Status? status,
    Hobbies? hobbies,
  }) {
    return ProfileInfoState(
      status: status ?? this.status,
      // data: data ?? this.data,
      hobbies: hobbies ?? this.hobbies,
    );
  }
}
