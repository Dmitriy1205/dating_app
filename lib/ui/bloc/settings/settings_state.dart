part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final Status? status;

  const SettingsState({
    this.status,
  });

  @override
  List<Object?> get props => [status];

  SettingsState copyWith({
    Status? status,
  }) {
    return SettingsState(
      status: status ?? this.status,
    );
  }
}
