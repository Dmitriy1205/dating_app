part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Status? status;

  const AuthState({
    this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];

  AuthState copyWith({
    Status? status,
  }) {
    return AuthState(
      status: status ?? this.status,
    );
  }
}
