import 'package:bloc/bloc.dart';
import 'package:dating_app/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/service_locator.dart';
import '../../data/models/message_model.dart';
import '../../data/models/status.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.db, this.auth)
      : super(MessengerStates(
          messagesList: [],
          status: Status.initial(),
        )) {
    // messagesStream();
  }

  final FirebaseAuth auth;
  List<MessageModel> messagesList = [];
  final DataRepository db;
  UserRepository loggedUser = sl<UserRepository>();
  String getChatId = '';
  String loggedUserPicture = '';
  get getLoggedUserId => auth.currentUser!.uid;
  get getLoggedUserPictureUrl => loggedUserPicture;

  Future<void> loggedUserPictureUrl()async {
    await db.getProfileFields(getLoggedUserId).then((value) => loggedUserPicture = value!.image!);
  }
  // get getChatId => db.getClearId(loggedUserId, openedChatUserId);

  void getChatId2(String openedChatUserId) {
    getChatId = db.getClearId(getLoggedUserId, openedChatUserId);
  }

  void sendMessage(MessageModel messageModel, UserModel userModel,
      [bool attachment = false]) async {
    messageModel.senderName = loggedUser.getUserName;
    if (attachment) {
      messageModel.attachmentUrl = 'chats/$getChatId/${DateTime.now()}';
    }
    db.sendMessageToPal(messageModel, getChatId);
  }

  void messagesStream(String openedChatUserId) async {
    // final user = await db.getUserFields(openedChatUserId);
    final messages = db
        .getAllChatMessagesStream(getLoggedUserId, openedChatUserId)
        .listen((event) {});
    messages.onData((data) {
      if (data.isNotEmpty) {
        emit(state.copyWith(messagesList: data, status: Status.loaded()));
      } else {
        emit(state.copyWith(status: Status.initial()));
      }
    });
  }
}

class MessengerStates extends Equatable {
  final Status? status;
  final List<MessageModel> messagesList;
  final UserModel? palUser;

  MessengerStates({this.status, required this.messagesList, this.palUser});

  MessengerStates copyWith(
      {Status? status, List<MessageModel>? messagesList, UserModel? palUser}) {
    return MessengerStates(
        status: status ?? this.status,
        messagesList: messagesList ?? this.messagesList,
        palUser: palUser ?? this.palUser);
  }

  @override
  List<Object?> get props => [status, messagesList];
}
