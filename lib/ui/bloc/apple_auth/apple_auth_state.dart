part of 'apple_auth_cubit.dart';

class AppleAuthState extends Equatable {
  final Status? status;

  const AppleAuthState({
    this.status,
  });

  @override
  List<Object?> get props => [status];

  AppleAuthState copyWith({
    Status? status,
  }) {
    return AppleAuthState(
      status: status ?? this.status,
    );
  }
}
