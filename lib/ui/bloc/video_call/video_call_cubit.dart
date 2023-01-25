import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/video_call_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
  CallModel? callModel;

  Future<void> initAgora({required bool isCaller, String? audio}) async {
    await engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    await engine.enableVideo();
    await engine.startPreview();

    engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print("local user ${connection.localUid} joined");
        emit(state.copyWith(localUserJoined: true));
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        debugPrint("remote user $remoteUid joined");
        assetsAudioPlayer.stop();
        emit(state.copyWith(status: Status.loaded(), remoteUid: remoteUid));
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        assetsAudioPlayer.stop();
        debugPrint("remote user $remoteUid left channel");
        emit(state.copyWith(
          remoteUid: null,
        ));
      },
      onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
        debugPrint(
            '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
      },
      onLeaveChannel: (connection, stats) {
        engine.disableVideo();
        engine.disableAudio();
        assetsAudioPlayer.release();

        emit(state.copyWith(remoteUid: null));
      },
      onError: (ErrorCodeType e, String s){
        emit(state.copyWith(status: Status.error(e.name)));
      }
    ));

    callStatusStreamSubscription = repo.getTemporaryTokenFromFirebase();
    callStatusStreamSubscription!.onData((data) async {
      String tempToken = data.data()!['token'];
      await engine.joinChannel(
        token: tempToken,
        channelId: testChannel,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );
    });

    if (isCaller) {
      playContactingRing(isCaller: true, audio: audio!);
    }
  }

  Future<void> performEndCall({required CallModel callModel}) async {
    await repo.endCurrentCall(callId: callModel.id);
    await repo.updateUserBusyStatusFirestore(callModel: callModel, busy: false);
  }

  void updateCallStatusToUnAnswered({required String callId}) {
    repo.updateCallStatus(callId: callId, status: CallStatus.unAnswer.name);
  }

  Future<void> updateCallStatusToAccept({
    required CallModel callModel,
  }) async {
    emit(state.copyWith(status: Status.loading()));
    await repo.updateCallStatus(
        callId: callModel.id, status: CallStatus.accept.name);

    await initAgora(
      isCaller: false,
    );
  }

  Future<void> updateCallStatusToReject({required String callId}) async {
    await repo.updateCallStatus(callId: callId, status: CallStatus.reject.name);
    // assetsAudioPlayer.stop();
    // await repo.endCurrentCall(callId: callId);
    // await engine.leaveChannel();
  }

  Future<void> updateCallStatusToCancel({required String callId}) async {
    await repo.updateCallStatus(callId: callId, status: CallStatus.cancel.name);
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
    // ByteData bytes = await rootBundle.load(audio);
    // Uint8List soundBytes =
    //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    // int result = await assetsAudioPlayer.playBytes(soundBytes);
    //
    // if (result == 1) {
    //   //play success
    //   debugPrint("Sound playing successful.");
    // } else {
    //   debugPrint("Error while playing sound.");
    // }

    await assetsAudioPlayer.play(AssetSource(audio));

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
      // updateCallStatusToUnAnswered();
    });
  }

  void listenToCallStatus({required String callModelId}) {
    callStatusStreamSubscription = repo.listenToCallStatus(callId: callModelId);
    callStatusStreamSubscription!.onData((data) {
      if (data.exists) {
        String status = data.data()!['status'];
        if (status == CallStatus.accept.name) {
          // sl<RegisterCallCubit>().currentCallStatus = CallStatus.accept;
          debugPrint('acceptStatus');
          emit(state.copyWith(callStatus: CallStatus.accept));
        }
        if (status == CallStatus.reject.name) {
          // sl<RegisterCallCubit>().currentCallStatus = CallStatus.reject;
          debugPrint('rejectStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.reject));
        }
        if (status == CallStatus.unAnswer.name) {
          // sl<RegisterCallCubit>().currentCallStatus = CallStatus.unAnswer;
          debugPrint('unAnswerStatusHere');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.unAnswer));
        }
        if (status == CallStatus.cancel.name) {
          // sl<RegisterCallCubit>().currentCallStatus = CallStatus.cancel;
          debugPrint('cancelStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.cancel));
        }
        if (status == CallStatus.end.name) {
          // sl<RegisterCallCubit>().currentCallStatus = CallStatus.end;
          debugPrint('endStatus');
          callStatusStreamSubscription!.cancel();
          emit(state.copyWith(callStatus: CallStatus.end));
        }
      }
    });
  }

  getInfo(String callId) {
    emit(state.copyWith(status: Status.loading()));
    callStatusStreamSubscription = repo.getCallName(callId: callId);
    callStatusStreamSubscription!.onData((data) {
      String callerName = data.data()['callerName'];
      String receiverName = data.data()['receiverName'];
      emit(state.copyWith(
          status: Status.loaded(), caller: callerName, reciver: receiverName));
    });
  }
}
