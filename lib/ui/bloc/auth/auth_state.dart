part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Status? status;
  final String? verId;

  const AuthState({
    this.verId,
    this.status,
  });

  @override
  List<Object?> get props => [
        status,
        verId,
      ];

  AuthState copyWith({
    Status? status,
    String? verId,
  }) {
    return AuthState(
      status: status ?? this.status,
      verId: verId ?? this.verId,
    );
  }
}
