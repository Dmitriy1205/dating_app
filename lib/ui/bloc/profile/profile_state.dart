part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Status? status;
  final ProfileInfoFields? profile;
  final UserFields? user;
  final List<String>? images;
  final Map<String,dynamic>? lookingFor;

  const ProfileState({
    this.status,
    this.profile,
    this.user,
    this.images,
    this.lookingFor,
  });

  @override
  List<Object?> get props => [
        status,
        profile,
        user,
        images,
        lookingFor,
      ];

  ProfileState copyWith({
    Status? status,
    ProfileInfoFields? profile,
    UserFields? user,
    List<String>? images,
    Map<String,dynamic>? lookingFor,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      user: user ?? this.user,
      images: images ?? this.images,
      lookingFor: lookingFor ?? this.lookingFor,
    );
  }
}
