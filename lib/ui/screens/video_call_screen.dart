import 'package:dating_app/data/models/call_model.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../core/service_locator.dart';
import '../../core/services/cache_helper.dart';
import '../bloc/video_call/video_call_cubit.dart';
import '../widgets/reusable_widgets.dart';

class VideoCallScreen extends StatelessWidget {
  final String id;
  final bool isReceiver;
  final String receiverId;

  const VideoCallScreen({
    Key? key,
    required this.receiverId,
    required this.id,
    required this.isReceiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<VideoCallCubit>(),
      child: _VideoCallScreen(
        receiverId: receiverId,
        id: id,
        isReceiver: isReceiver,
      ),
    );
  }
}

class _VideoCallScreen extends StatefulWidget {
  final String id;
  final String receiverId;
  final bool isReceiver;

  const _VideoCallScreen({
    Key? key,
    required this.receiverId,
    required this.id,
    required this.isReceiver,
  }) : super(key: key);

  @override
  State<_VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<_VideoCallScreen> {
  late VideoCallCubit cubit = VideoCallCubit(repo: sl());

  @override
  void initState() {
    super.initState();
    context.read<VideoCallCubit>().listenToCallStatus(callModelId: widget.id);

    if (!widget.isReceiver) {
      context.read<VideoCallCubit>().initAgora(
            isCaller: true,
            audio: Content.outgoingCall,
          );
    } else {
      context
          .read<VideoCallCubit>()
          .playContactingRing(isCaller: false, audio: Content.incomingCall);
    }
  }

  @override
  void dispose() {
    cubit.assetsAudioPlayer.dispose();
    cubit.engine.release();
    if (!widget.isReceiver) {
      //Sender
      cubit.countDownTimer.cancel();
    }
    // cubit.performEndCall(
    //     callModel: CallModel(
    //   id: widget.id,
    //   callerId: CacheHelper.getString(key: 'uId'),
    //   receiverId: widget.receiverId,
    //   status: CallStatus.end.name,
    // ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCallCubit, VideoCallState>(
      listener: (context, state) {
        // if (state.remoteUid == null) {
        //   context
        //       .read<VideoCallCubit>()
        //       .updateCallStatusToUnAnswered(callId: widget.id);
        // }
        if (state.callStatus == CallStatus.unAnswer) {
          if (!widget.isReceiver) {
            //Caller
            ReUsableWidgets.showToast(msg: 'No response!');
          }
          Navigator.pop(context);
        }
        if (state.callStatus == CallStatus.cancel) {
          if (widget.isReceiver) {
            context.read<VideoCallCubit>().leave();
            Navigator.pop(context);
            //Caller
            ReUsableWidgets.showToast(msg: 'Caller cancel the call!');
          }

        }
        if (state.callStatus == CallStatus.reject) {
          if (!widget.isReceiver) {
            context.read<VideoCallCubit>().leave();
            ReUsableWidgets.showToast(msg: 'Receiver reject the call!');
          }

          Navigator.pop(context);
        }
        if (state.callStatus == CallStatus.end) {
          if (widget.isReceiver) {
            //Caller
            ReUsableWidgets.showToast(msg: 'Call ended!');
          }
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Stack(
            children: [
              Center(
                  child: _remoteVideo(
                state.remoteUid,
                widget.isReceiver,
              )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 85),
                  child: Container(
                    width: 140,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: state.localUserJoined
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine:
                                      context.read<VideoCallCubit>().engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              )
                            : const CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              state.remoteUid == null
                  ? widget.isReceiver
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 11),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                context.read<VideoCallCubit>().performEndCall(
                                        callModel: CallModel(
                                      id: widget.id,
                                      callerId:
                                          CacheHelper.getString(key: 'uId'),
                                      receiverId: widget.receiverId,
                                      status: CallStatus.end.name,
                                    ));
                                context
                                    .read<VideoCallCubit>()
                                    .updateCallStatusToCancel(
                                        callId: widget.id);
                                Navigator.pop(context);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (_) => const VideoCallScreen()));
                              },
                              child: SizedBox(
                                height: 95,
                                width: 95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Icon(
                                    Icons.call_end,
                                    size: 55,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 11),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<VideoCallCubit>()
                                .updateCallStatusToReject(callId: widget.id);
                          },
                          child: SizedBox(
                            height: 95,
                            width: 95,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Icon(
                                Icons.call_end,
                                size: 55,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              state.remoteUid == null
                  ? widget.isReceiver
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 18,
                              left: MediaQuery.of(context).size.height / 15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () {
                                //TODO: accept call
                                context
                                    .read<VideoCallCubit>()
                                    .updateCallStatusToAccept(
                                        callModel: CallModel(id: widget.id));
                              },
                              child: SizedBox(
                                height: 65,
                                width: 65,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Icon(
                                    Icons.call,
                                    size: 35,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 25,
                              left: MediaQuery.of(context).size.height / 15),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () {
                                context.read<VideoCallCubit>().switchCamera();
                              },
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Icon(
                                    Icons.change_circle_rounded,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 25,
                          left: MediaQuery.of(context).size.height / 15),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.read<VideoCallCubit>().switchCamera();
                          },
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Icon(
                                Icons.change_circle_rounded,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              state.remoteUid == null
                  ? widget.isReceiver
                      ? Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 18,
                              right: MediaQuery.of(context).size.height / 15),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                //TODO: decline call
                                context
                                    .read<VideoCallCubit>()
                                    .updateCallStatusToReject(
                                        callId: widget.id);
                              },
                              child: SizedBox(
                                height: 65,
                                width: 65,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Icon(
                                    Icons.call_end,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 25,
                              right: MediaQuery.of(context).size.height / 15),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<VideoCallCubit>()
                                    .switchAudio(!state.mute);
                              },
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: state.mute
                                      ? const Icon(
                                          Icons.mic_off_rounded,
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.mic,
                                          size: 35,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 25,
                          right: MediaQuery.of(context).size.height / 15),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<VideoCallCubit>()
                                .switchAudio(!state.mute);
                          },
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: state.mute
                                  ? const Icon(
                                      Icons.mic_off_rounded,
                                      size: 35,
                                    )
                                  : const Icon(
                                      Icons.mic,
                                      size: 35,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _remoteVideo(int? remoteUid, bool isReceiver) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: context.read<VideoCallCubit>().engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: const RtcConnection(channelId: testChannel),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        child: Column(
          children: [
            isReceiver ? Text('Calling to you...') : Text('Calling to ..'),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }
  }
}
