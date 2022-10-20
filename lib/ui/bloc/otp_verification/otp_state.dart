part of 'otp_cubit.dart';

class OtpState extends Equatable {
  final Status? status;

  const OtpState({this.status});

  @override
  List<Object?> get props => [
        status,
      ];

  OtpState copyWith({
    Status? status,
  }) {
    return OtpState(
      status: status ?? this.status,
    );
  }
}
