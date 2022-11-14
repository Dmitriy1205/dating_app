part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status? status;
  final List<ProfileInfoFields>? fields;
  final List<SearchPrefFields>? lookingFor;
  final List<UserFields>? user;

  const HomeState({
    this.status,
    this.fields,
    this.lookingFor,
    this.user,
  });

  @override
  List<Object?> get props => [
        status,
        fields,
        lookingFor,
        user,
      ];

  HomeState copyWith({
    Status? status,
    List<ProfileInfoFields>? fields,
    List<SearchPrefFields>? lookingFor,
    List<UserFields>? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      fields: fields ?? this.fields,
      lookingFor: lookingFor ?? this.lookingFor,
      user: user ?? this.user,
    );
  }
}
