part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final ProfileInfoFields? profile;
  final UserModel? user;
  final List<String>? images;
  final List<dynamic>? lookingForFields;

  const ProfileState({
    this.status,
    this.profile,
    this.user,
    this.images,
    this.lookingForFields,
  });

  @override
  List<Object?> get props => [
        status,
        profile,
        user,
        images,
        lookingForFields,
      ];

  ProfileState copyWith({
    Status? status,
    ProfileInfoFields? profile,
    UserModel? user,
    List<String>? images,
    List<dynamic>? lookingForFields,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      user: user ?? this.user,
      images: images ?? this.images,
      lookingForFields: lookingForFields ?? this.lookingForFields,
    );
  }
}
