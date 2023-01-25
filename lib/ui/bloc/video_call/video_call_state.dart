part of 'video_call_cubit.dart';

class VideoCallState extends Equatable {
  final Status? status;
  final CallStatus? callStatus;
  final bool localUserJoined;
  final int? remoteUid;
  final bool mute;
  final String? caller;
  final String? reciver;

  const VideoCallState({
    this.status,
    this.callStatus,
    this.localUserJoined = false,
    this.remoteUid,
    this.mute = false,
    this.caller,
    this.reciver,
  });

  VideoCallState copyWith({
    Status? status,
    CallStatus? callStatus,
    bool? localUserJoined,
    int? remoteUid,
    bool? mute,
    String? caller,
    String? reciver,
  }) {
    return VideoCallState(
      status: status ?? this.status,
      callStatus: callStatus ?? this.callStatus,
      localUserJoined: localUserJoined ?? this.localUserJoined,
      remoteUid: remoteUid ?? this.remoteUid,
      mute: mute ?? this.mute,
      caller: caller ?? this.caller,
      reciver: reciver ?? this.reciver,
    );
  }

  @override
  List<Object?> get props => [
        status,
        callStatus,
        localUserJoined,
        remoteUid,
        mute,
        caller,
        reciver,
      ];
}
