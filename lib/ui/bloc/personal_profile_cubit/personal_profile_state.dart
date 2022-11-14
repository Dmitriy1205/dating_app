part of 'personal_profile_cubit.dart';

class PersonalProfileState extends Equatable {
  final Status? status;
  final List<String>? pic;

  const PersonalProfileState({
    this.status,
    this.pic,
  });

  @override
  List<Object?> get props => [
        status,
        pic,
      ];

  PersonalProfileState copyWith({
    Status? status,
    List<String>? pic,
  }) {
    return PersonalProfileState(
      status: status ?? this.status,
      pic: pic ?? this.pic,
    );
  }
}
