part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final Status? status;

  const SignInState({
    this.status,
  });

  SignInState copyWith({
    final Status? status,
  }) {
    return SignInState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
