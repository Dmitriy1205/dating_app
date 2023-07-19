import 'package:bloc/bloc.dart';
import 'package:dating_app/core/services/fcm_service.dart';
import 'package:dating_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/services/service_locator.dart';
import '../../data/models/message_model.dart';
import '../../data/models/status.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  final FirebaseAuth auth;
  final DataRepository db;

  MessengerCubit(this.db, this.auth, UserModel userModel)
      : super(MessengerStates(
          messagesList: const [],
          status: Status.initial(),
        )) {
    // messagesStream();
  }
bool onMessengerScreen = false;

  // List<MessageModel> messagesList = [];
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  UserRepository loggedUser = sl<UserRepository>();
  String getChatId = '';
  String loggedUserPicture = '';

  get getLoggedUserId => auth.currentUser!.uid;

  Future<void> getUsersBlock({
    required String currentUserId,
    required String blockerUserId,
  }) async {
    bool? isBlocked = await db
        .isUserBlocked(currentUserId, blockerUserId)
        .then((value) => value!.isBlocked);
    emit(state.copyWith(userBlocked: isBlocked));
  }

  Future<void> loggedUserPictureUrl() async {
    await db.getUserFields(getLoggedUserId).then((value) => loggedUserPicture =
        value!.profileInfo!.image ??
            'https://firebasestorage.googleapis.com/v0/b/dating-app-95830.appspot.com/o/users%2F7kyZ3iSjKUQyQHNTNpB1gzU8pP33%2Fimage2.png?alt=media&token=968c17f4-46ee-4e0b-a3e7-b6d0a92c3f4c');
  }

  void getChatId2(String openedChatUserId) {
    getChatId = db.getClearId(getLoggedUserId, openedChatUserId);
  }

  void sendMessage(MessageModel messageModel, UserModel userModel,
      [bool attachment = false]) async {
    messageModel.senderName = loggedUser.getUserName;
    messageModel.chatId = getChatId;
    if (attachment) {
      messageModel.attachmentUrl = 'chats/$getChatId/${DateTime.now()}';
    }
    db.sendMessageToPal(messageModel, getChatId);
  }


  void messagesStream(String openedChatUserId) async {
    final messages = db
        .getAllChatMessagesStream(getLoggedUserId, openedChatUserId)
        .listen((event) {});
    messages.onData((data) {
      if (data.isNotEmpty) {
        emit(state.copyWith(messagesList: data, status: Status.loaded()));
        if (!data[0].isRead!) {
          print('isRead! + ');

          if (data[0].senderName != loggedUser.getUserName) {
            print('!data[0].isRead! ${!data[0].isRead!}');
            flutterLocalNotificationsPlugin.show(0, data[0].senderName!,
                data[0].message!, sl<FCMService>().platformChannelSpecifics);

            // FCMService.showReceivedMessageNotification(
            //     title: data[0].senderName!,
            //     payload: 'payload',
            //     body: data[0].message!,
            //     fln: Notifications.flutterLocalNotificationsPlugin);
          }
        }
      } else {
        emit(state.copyWith(status: Status.initial()));
      }
    });
  }

  void clearChat() async {
    db.clearChat(getChatId);
  }

  void palReadMessage(MessageModel message) {
    db.palReadMessage(message);
  }

  Future<void> blockUser(String id) async {
    await db.blockContact(id, currentUserId: auth.currentUser!.uid);
  }
}

class MessengerStates extends Equatable {
  final Status? status;
  final List<MessageModel> messagesList;
  final UserModel? palUser;
  final bool? userBlocked;

  const MessengerStates({
    this.status,
    required this.messagesList,
    this.palUser,
    this.userBlocked,
  });

  MessengerStates copyWith({
    Status? status,
    List<MessageModel>? messagesList,
    UserModel? palUser,
    bool? userBlocked,
  }) {
    return MessengerStates(
      status: status ?? this.status,
      messagesList: messagesList ?? this.messagesList,
      palUser: palUser ?? this.palUser,
      userBlocked: userBlocked ?? this.userBlocked,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messagesList,
        userBlocked,
      ];
}
