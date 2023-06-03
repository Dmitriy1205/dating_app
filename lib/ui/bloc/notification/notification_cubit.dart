import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/status.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository notificationRepo;
  final DataRepository firestoreRepo;
  final AuthRepository authRepository;

  NotificationCubit({
    required this.notificationRepo,
    required this.firestoreRepo,
    required this.authRepository,
  }) : super(NotificationState(status: Status.initial()));

  Future<void> saveToken({required String currentUserId}) async {
    String? token = await notificationRepo.getToken();
    await firestoreRepo.saveToken(token: token!, currentUserId: currentUserId);
    emit(state.copyWith(status: Status.loaded()));
  }

  Future<void> sendMessageNotification(
      {required String userId,
      required String senderName,
      required String message}) async {
    final data = await firestoreRepo.getField(
        collectionName: 'fcmTokens', userId: userId);
    String token = data['token'];
    await notificationRepo.sendMessage(
        token: token, body: message, title: senderName, type: 'message');
    emit(state.copyWith(status: Status.loaded()));
  }

  Future<void> sendCallNotification({
    required String userId,
    required String callerName,
  }) async {
    final data = await firestoreRepo.getField(
        collectionName: 'fcmTokens', userId: userId);
    String token = data['token'];
    await notificationRepo.sendMessage(
        token: token, body: 'incoming call', title: callerName, type: 'call');
    emit(state.copyWith(status: Status.loaded()));
  }

  Future<void> cancel() async {
    notificationRepo.cancelNotification();
  }
}
