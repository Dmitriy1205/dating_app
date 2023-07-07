part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Status? status;

  const SignUpState({
    this.status,
  });

  SignUpState copyWith({
    final Status? status,
    final ConnectivityStatus? connectionStatus,
  }) {
    return SignUpState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
