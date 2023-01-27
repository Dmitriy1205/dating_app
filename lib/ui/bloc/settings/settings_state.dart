part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Status? status;
  final List<UserModel>? usersList;

  const SettingsState({
    this.status,
    this.usersList,
  });

  @override
  List<Object?> get props => [
        status,
        usersList,
      ];

  SettingsState copyWith({
    Status? status,
    List<UserModel>? usersList,
  }) {
    return SettingsState(
      status: status ?? this.status,
      usersList: usersList ?? this.usersList,
    );
  }
}
