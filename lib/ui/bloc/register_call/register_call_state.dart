part of 'register_call_cubit.dart';

class RegisterCallState extends Equatable {
  final Status? status;
  final CallStatus? callStatus;
  final IncomingCallStatus? inCallStatus;
  final CallModel? callModel;

  const RegisterCallState({
    this.status,
    this.inCallStatus,
    this.callModel,
    this.callStatus,
  });

  RegisterCallState copyWith({
    Status? status,
    IncomingCallStatus? inCallStatus,
    CallModel? callModel,
    CallStatus? callStatus,
  }) {
    return RegisterCallState(
      status: status ?? this.status,
      inCallStatus: inCallStatus ?? this.inCallStatus,
      callModel: callModel ?? this.callModel,
      callStatus: callStatus ?? this.callStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        inCallStatus,
        callModel,
        callStatus,
      ];
}
