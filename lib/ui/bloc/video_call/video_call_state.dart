part of 'video_call_cubit.dart';

class VideoCallState extends Equatable {
  final Status? status;
  final CallStatus? callStatus;
  final bool localUserJoined;
  final int? remoteUid;
  final bool mute;
  final CallModel? callModel;

  const VideoCallState({
    this.status,
    this.callStatus,
    this.localUserJoined = false,
    this.remoteUid,
    this.mute = false,
    this.callModel,
  });

  VideoCallState copyWith({
    Status? status,
    CallStatus? callStatus,
    bool? localUserJoined,
    int? remoteUid,
    bool? mute,
    CallModel? callModel,
  }) {
    return VideoCallState(
      status: status ?? this.status,
      callStatus: callStatus ?? this.callStatus,
      localUserJoined: localUserJoined ?? this.localUserJoined,
      remoteUid: remoteUid ?? this.remoteUid,
      mute: mute ?? this.mute,
      callModel: callModel ?? this.callModel,
    );
  }

  @override
  List<Object?> get props => [
        status,
        callStatus,
        localUserJoined,
        remoteUid,
        mute,
        callModel,
      ];
}
