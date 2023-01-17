import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/call_model.dart';
import 'package:dating_app/data/repositories/video_call_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants.dart';
import '../../../core/services/cache_helper.dart';
import '../../../core/services/dio_helper.dart';
import '../../../data/models/fcm_payload_model.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user_token_model.dart';

part 'register_call_state.dart';

class RegisterCallCubit extends Cubit<RegisterCallState> {
  RegisterCallCubit({required this.repo}) : super(const RegisterCallState());

  final VideoCallRepository repo;
  CallStatus? currentCallStatus;

  Future<void> makeCall({required CallModel callModel}) async {
    // emit(state.copyWith(status: Status.loading()));
    Map<String, dynamic> queryMap = {
      'channelName': 'channel_${UniqueKey().hashCode.toString()}',
      'uid': callModel.callerId,
    };
    try {
      callModel.token = testToken;
      callModel.channelName = testChannel;
      postCallToFirestore(callModel: callModel);
    } catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  void postCallToFirestore({required CallModel callModel}) {
    repo.postCallToFirestore(callModel: callModel).then((value) {
      repo
          .updateUserBusyStatusFirestore(callModel: callModel, busy: true)
          .then((value) {
        sendNotificationForIncomingCall(callModel: callModel);
      }).catchError((onError) {
        emit(state.copyWith(status: Status.error(onError.toString())));
      });
    }).catchError((onError) {
      emit(state.copyWith(status: Status.error(onError.toString())));
    });
  }

  void sendNotificationForIncomingCall({required CallModel callModel}) {
    FirebaseFirestore.instance
        .collection('Tokens')
        .doc(callModel.receiverId)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> bodyMap = {
          'type': 'call',
          'title': 'New call',
          'body': jsonEncode(callModel.toMap())
        };
        FcmPayloadModel fcmSendData =
            FcmPayloadModel(to: value.data()!['token'], data: bodyMap);
        emit(state.copyWith(inCallStatus: IncomingCallStatus.successOuterCall, callModel: callModel));
        // DioHelper.postData(
        //   data: fcmSendData.toMap(),
        //   baseUrl: 'https://fcm.googleapis.com/',
        //   endPoint: 'fcm/send',
        // ).then((value) {
        //   debugPrint('SendNotifySuccess ${value.data.toString()}');
        //   emit(state.copyWith(
        //       inCallStatus: IncomingCallStatus.successOuterCall,
        //       callModel: callModel));
        // }).catchError((onError) {
        //   debugPrint('Error when send Notify: $onError');
        //
        //   emit(state.copyWith(status: Status.error(onError.toString())));
        // });
      }
    }).catchError((onError) {
      debugPrint('Error when get user token: $onError');

      emit(state.copyWith(status: Status.error(onError.toString())));
    });
  }

  void listenToInComingCalls() {
    repo.listenToInComingCall().onData((data) {
      if (data.size != 0) {
        for (var element in data.docs) {
          if (element.data()['current'] == true) {
            String status = element.data()['status'];
            if (status == CallStatus.ringing.name) {
              currentCallStatus = CallStatus.ringing;
              debugPrint('ringingStatus');
              emit(state.copyWith(
                  inCallStatus: IncomingCallStatus.successIncomingCall,
                  callModel: CallModel.fromJson(element.data())));
            }
            else if (status == CallStatus.cancel.name){
              currentCallStatus = CallStatus.cancel;
              emit(state.copyWith(callStatus: CallStatus.cancel));
            }
          }
        }
      }
      print('sdfdsfdfs');
    });
  }

  void updateFcmToken({required String uId}) {
    FirebaseMessaging.instance.getToken().then((token) {
      UserTokenModel tokenModel = UserTokenModel(token: token!, uId: uId);
      FirebaseFirestore.instance
          .collection('Tokens')
          .doc(CacheHelper.getString(key: 'uId'))
          .set(tokenModel.toMap())
          .then((value) {
        debugPrint('User Fcm Token Updated $token');
      }).catchError((onError) {
        debugPrint(onError.toString());
      });
    });
  }
}
