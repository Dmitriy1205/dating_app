part of 'google_auth_cubit.dart';

class GoogleAuthState extends Equatable {
  final Status? status;

  const GoogleAuthState({
    this.status,
  });

  @override
  List<Object?> get props => [status];

  GoogleAuthState copyWith({
    Status? status,
  }) {
    return GoogleAuthState(
      status: status ?? this.status,
    );
  }
}
