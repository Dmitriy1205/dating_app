part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status? status;

  // final List<ProfileInfoFields>? fields;
  // final List<SearchPrefFields>? lookingFor;
  final List<UserModel>? user;
  final bool? match;
  final UserModel? matchUser;
  final UserModel? currentUser;

  const HomeState({
    this.status,
    // this.fields,
    // this.lookingFor,
    this.user,
    this.match,
    this.matchUser,
    this.currentUser,
  });

  @override
  List<Object?> get props => [
        status,
        // fields,
        // lookingFor,
        user,
        match,
        matchUser,
    currentUser,
      ];

  HomeState copyWith({
    Status? status,
    List<ProfileInfoFields>? fields,
    List<SearchPrefFields>? lookingFor,
    List<UserModel>? user,
    bool? match,
    UserModel? matchUser,
    UserModel? currentUser,
  }) {
    return HomeState(
      status: status ?? this.status,
      // fields: fields ?? this.fields,
      // lookingFor: lookingFor ?? this.lookingFor,
      user: user ?? this.user,
      match: match ?? this.match,
      matchUser: matchUser ?? this.matchUser,
      currentUser: currentUser??this.currentUser,
    );
  }
}
