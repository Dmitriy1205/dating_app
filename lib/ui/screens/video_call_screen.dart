import 'package:agora_uikit/agora_uikit.dart';
import 'package:dating_app/data/models/call_model.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../core/service_locator.dart';
import '../../core/services/cache_helper.dart';
import '../bloc/video_call/video_call_cubit.dart';
import '../widgets/reusable_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late VideoCallCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<VideoCallCubit>(context);
    getPermissions();
    cubit.getInfo(widget.id);

    cubit.listenToCallStatus(callModelId: widget.id);

    if (!widget.isReceiver) {
      cubit.initAgora(
        isCaller: true,
        audio: Content.outgoingCall,
      );
    } else {
      cubit.playContactingRing(isCaller: false, audio: Content.incomingCall);
    }
  }

  Future<void> getPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  void dispose() {
    cubit.assetsAudioPlayer.release();
    cubit.engine.release();
    cubit.performEndCall(
        callModel: CallModel(
      id: widget.id,
      callerId: CacheHelper.getString(key: 'uId'),
      receiverId: widget.receiverId,
      status: CallStatus.end.name,
    ));
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
        // if (state.callStatus == CallStatus.unAnswer) {
        //   if (!widget.isReceiver) {
        //     //Caller
        //     ReUsableWidgets.showToast(msg: ${AppLocalizations.of(context)!.noResponse});
        //   }
        //   Navigator.pop(context);
        // }
        if (state.status!.isError) {
          ReUsableWidgets.showToast(msg: state.status!.errorMessage.toString());
          Navigator.pop(context);
        } else if (state.callStatus == CallStatus.cancel) {
          if (widget.isReceiver) {
            //Caller
            ReUsableWidgets.showToast(
                msg:
                    '${state.caller} ${AppLocalizations.of(context)!.cancelTheCall}');
          }

          Navigator.pop(context);
        }
        if (state.callStatus == CallStatus.reject) {
          if (!widget.isReceiver) {
            ReUsableWidgets.showToast(
                msg:
                    '${state.reciver} ${AppLocalizations.of(context)!.rejectTheCall}');
          }

          Navigator.pop(context);
        }
        // if (state.callStatus == CallStatus.end) {
        //   if (widget.isReceiver) {
        //     //Caller
        //     ReUsableWidgets.showToast(msg: 'Call ended!');
        //   }
        //   Navigator.pop(context);
        // }
      },
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.shade100,
                      Colors.orange.shade400,
                    ],
                  ),
                ),
              ),
              Center(
                  child: _remoteVideo(
                state.remoteUid,
                widget.isReceiver,
                state.caller!,
                state.reciver!,
              )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 85),
                  child: Container(
                    width: 140,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: state.localUserJoined == true
                            ? AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: cubit.engine,
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
              widget.isReceiver
                  ? state.remoteUid == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 11),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                cubit.updateCallStatusToReject(
                                    callId: widget.id);
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
                        )
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 11),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            cubit.updateCallStatusToCancel(callId: widget.id);
                            // context.read<VideoCallCubit>().performEndCall(
                            //         callModel: CallModel(
                            //       id: widget.id,
                            //       callerId: CacheHelper.getString(key: 'uId'),
                            //       receiverId: widget.receiverId,
                            //       status: CallStatus.end.name,
                            //     ));

                            // Navigator.pop(context);
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

                                cubit.updateCallStatusToAccept(
                                  callModel: CallModel(
                                    id: widget.id,
                                  ),
                                );
                              },
                              child: SizedBox(
                                height: 65,
                                width: 65,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: const Icon(
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
                                cubit.switchCamera();
                              },
                              child: const SizedBox(
                                height: 45,
                                width: 45,
                                child: Icon(
                                  Icons.change_circle_rounded,
                                  size: 35,
                                  color: Colors.white,
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
                            cubit.switchCamera();
                          },
                          child: const SizedBox(
                            height: 45,
                            width: 45,
                            child: Icon(
                              Icons.change_circle_rounded,
                              size: 35,
                              color: Colors.white,
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
                                cubit.updateCallStatusToReject(
                                    callId: widget.id);
                              },
                              child: SizedBox(
                                height: 65,
                                width: 65,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: const Icon(
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
                                cubit.switchAudio(!state.mute);
                              },
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: state.mute
                                    ? const Icon(
                                        Icons.mic_off_rounded,
                                        size: 35,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.mic,
                                        size: 35,
                                        color: Colors.white,
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
                            cubit.switchAudio(!state.mute);
                          },
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: state.mute
                                ? const Icon(
                                    Icons.mic_off_rounded,
                                    size: 35,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.mic,
                                    size: 35,
                                    color: Colors.white,
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

  Widget _remoteVideo(
      int? remoteUid, bool isReceiver, String incoming, String outcoming) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: cubit.engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: const RtcConnection(channelId: testChannel),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        child: Column(
          children: [
            isReceiver
                ? Text(
                    '${incoming.toUpperCase()} \n\n${AppLocalizations.of(context)!.callingYou}',
                    textAlign: TextAlign.center,
                  )
                : Text(
                    '${AppLocalizations.of(context)!.callingTo} \n\n ${outcoming.toUpperCase()}...',
                    textAlign: TextAlign.center,
                  ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }
  }
}
