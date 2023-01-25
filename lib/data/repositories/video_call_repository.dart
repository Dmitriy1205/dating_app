import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/exceptions.dart';
import '../../core/services/cache_helper.dart';
import '../models/call_model.dart';

class VideoCallRepository {
  final FirebaseFirestore firestore;

  VideoCallRepository({required this.firestore});

  Future<List<CallModel>?> getCallInfo({required String callId}) async {
    final model = await firestore.collection('calls').doc(callId).get();
    final s = model.data()?.values.map((e) => CallModel.fromJson(e)).toList();

    return s;
  }

  Future<void> postCallToFirestore({required CallModel callModel}) async {
    try {
      await firestore
          .collection('calls')
          .doc(callModel.id)
          .set(callModel.toMap());
    } on Exception catch (e) {
      print('======================${e}');
    }
  }

  Future<void> updateUserBusyStatusFirestore({
    required CallModel callModel,
    required bool busy,
  }) async {
    try {
      Map<String, dynamic> busyMap = {'busy': busy};
      await firestore
          .collection('users')
          .doc(callModel.callerId)
          .update(busyMap)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(callModel.receiverId)
            .update(busyMap);
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> updateCallStatus(
      {required String callId, required String status}) {
    return firestore.collection('calls').doc(callId).update({'status': status});
  }

  Future<void> endCurrentCall({required String callId}) {
    return firestore.collection('calls').doc(callId).update({'current': false});
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      listenToInComingCall() {
    try {
      return firestore
          .collection('calls')
          .where('receiverId', isEqualTo: CacheHelper.getString(key: 'uId'))
          .snapshots()
          .listen((event) {});
    } on Exception catch (e) {
      throw BadRequestException;
    }
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> listenToCallStatus(
      {required String callId}) {
    return FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((event) {});
  }
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> getCallName(
      {required String callId}) {
    return FirebaseFirestore.instance
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((event) {});
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      getTemporaryTokenFromFirebase() {
    return firestore
        .collection('temporary')
        .doc('1')
        .snapshots()
        .listen((event) {});
  }
}
