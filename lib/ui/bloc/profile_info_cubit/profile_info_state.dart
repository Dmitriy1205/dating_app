part of 'profile_info_cubit.dart';

class ProfileInfoState extends Equatable {
  final Status? status;
  // final ProfileInfoData? data;

  const ProfileInfoState({
    // this.data,
    this.status,
  });

  @override
  List<Object?> get props => [
        status,
        // data,
      ];

  ProfileInfoState copyWith({
    Status? status,
    // ProfileInfoData? data,
  }) {
    return ProfileInfoState(
      status: status ?? this.status,
      // data: data ?? this.data,
    );
  }
}
