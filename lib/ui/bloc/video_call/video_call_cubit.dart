import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/video_call_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiver/async.dart';

import '../../../core/constants.dart';
import '../../../data/models/call_model.dart';
import '../../../data/models/status.dart';

part 'video_call_state.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  VideoCallCubit({required this.repo})
      : super(VideoCallState(status: Status.initial()));
  final VideoCallRepository repo;

  RtcEngine get engine => createAgoraRtcEngine();
  AudioPlayer assetsAudioPlayer = AudioPlayer();
  StreamSubscription? callStatusStreamSubscription;
  int current = 0;
  late CountdownTimer countDownTimer;

// Future<void> getInfo(String callId) async {
//     final model = await repo.getCallInfo(callId: callId);
//     emit(state.copyWith(callModel: model));
//   }

  Future<void> initAgora({
    required bool isCaller,
    String? audio,
  }) async {
    await [Permission.microphone, Permission.camera].request();

    await engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      debugPrint("local user ${connection.localUid} joined");
      emit(state.copyWith(localUserJoined: true));
    }, onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
      debugPrint("remote user $remoteUid joined");
      assetsAudioPlayer.stop();
      emit(state.copyWith(remoteUid: remoteUid));
    }, onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
      debugPrint("remote user $remoteUid left channel");
      emit(state.copyWith(remoteUid: null));
    }, onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
      debugPrint(
          '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
    }, onLeaveChannel: (RtcConnection, RtcStats) {
      assetsAudioPlayer.release();
    }));

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: testToken,
      channelId: testChannel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
    if (isCaller) {
      playContactingRing(isCaller: true, audio: audio!);
    }
  }

  Future<void> performEndCall({required CallModel callModel}) async {
    assetsAudioPlayer.stop();
    await leave();
    await repo.endCurrentCall(callId: callModel.id);
    await repo.updateUserBusyStatusFirestore(callModel: callModel, busy: false);
  }

  void updateCallStatusToUnAnswered({required String callId}) {
    repo.updateCallStatus(callId: callId, status: CallStatus.unAnswer.name);
  }

  Future<void> updateCallStatusToAccept({required CallModel callModel}) async {
    await repo.updateCallStatus(
        callId: callModel.id, status: CallStatus.accept.name);

    initAgora(isCaller: false);
  }

  Future<void> updateCallStatusToReject({required String callId}) async {
    assetsAudioPlayer.stop();
    await repo.endCurrentCall(callId: callId);
    await repo.updateCallStatus(callId: callId, status: CallStatus.reject.name);
  }

  Future<void> updateCallStatusToCancel({required String callId}) async {
    assetsAudioPlayer.stop();
    await repo.endCurrentCall(callId: callId);
    await repo.updateCallStatus(callId: callId, status: CallStatus.cancel.name);
  }

  Future<void> leave() async {
    await engine.leaveChannel();
    await engine.disableAudio();
    await engine.disableVideo();
  }

  Future<void> switchAudio(bool value) async {
    await engine.muteLocalAudioStream(value);
    emit(state.copyWith(mute: value));
  }

  Future<void> switchCamera() async {
    await engine.switchCamera();
    // emit(state.copyWith(status: Status.loaded()));
  }

  Future<void> playContactingRing(
      {required bool isCaller, required String audio}) async {
    ByteData bytes = await rootBundle.load(audio);
    Uint8List soundBytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await assetsAudioPlayer.playBytes(soundBytes);

    if (result == 1) {
      //play success
      debugPrint("Sound playing successful.");
    } else {
      debugPrint("Error while playing sound.");
    }
    if (isCaller) {
      startCountdownCallTimer();
    }
  }

  void startCountdownCallTimer() {
    countDownTimer = CountdownTimer(
      const Duration(seconds: callDurationInSec),
      const Duration(seconds: 1),
    );
    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      current = callDurationInSec - duration.elapsed.inSeconds;
      debugPrint("DownCount: $current");
    });

    sub.onDone(() {
      debugPrint("CallTimeDone");
      sub.cancel();
      emit(state.copyWith(status: Status.loaded()));
    });
  }

  void listenToCallStatus({required String callModelId}) {
    callStatusStreamSubscription = repo.listenToCallStatus(callId: callModelId);
    callStatusStreamSubscription!.onData((data) {
      if (data.exists) {
        String status = data.data()!['status'];
        if (status == CallStatus.accept.name) {
          // _homeCubit.currentCallStatus = CallStatus.accept;
          debugPrint('acceptStatus');
          emit(state.copyWith(callStatus: CallStatus.accept));
        }
        if (status == CallStatus.reject.name) {
          // _homeCubit.currentCallStatus = CallStatus.reject;
          debugPrint('rejectStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.reject));
        }
        if (status == CallStatus.unAnswer.name) {
          // _homeCubit.currentCallStatus = CallStatus.unAnswer;
          debugPrint('unAnswerStatusHere');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.unAnswer));
        }
        if (status == CallStatus.cancel.name) {
          // _homeCubit.currentCallStatus = CallStatus.cancel;
          debugPrint('cancelStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.cancel));
        }
        if (status == CallStatus.end.name) {
          // _homeCubit.currentCallStatus = CallStatus.end;
          debugPrint('endStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.end));
        }
      }
    });
  }
}
