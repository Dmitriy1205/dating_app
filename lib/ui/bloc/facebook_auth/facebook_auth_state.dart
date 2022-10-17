part of 'facebook_auth_cubit.dart';

class FacebookAuthState extends Equatable {
  final Status? status;

  const FacebookAuthState({
    this.status,
  });

  @override
  List<Object?> get props => [status];

  FacebookAuthState copyWith({
    Status? status,
  }) {
    return FacebookAuthState(
      status: status ?? this.status,
    );
  }
}
