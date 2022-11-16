import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/message_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.db, this.auth, this.userModel) : super(MessengerInit()) {
    messagesStream();
  }

  final UserModel userModel;
  final FirebaseAuth auth;
  List<MessageModel> messagesList = [];
  final DataRepository db;

  get currentUserId => auth.currentUser!.uid;

  get currentUserName => auth.currentUser!.displayName;

  get getChatId => db.getClearId(userModel.userId, currentUserId);

  void sendMessage(MessageModel messageModel, UserModel userModel,
      [bool attachment = false]) async {
    if (attachment) {
      messageModel.attachmentUrl = 'chats/$getChatId/${DateTime.now()}';
    } else {
      messageModel.senderName = currentUserName;
    }
    db.sendMessageToPal(messageModel, getChatId);
  }

  void messagesStream() async {
    final messages = db
        .getAllChatMessagesStream(userModel.userId!, currentUserId)
        .listen((event) {});
    messages.onData((data) {
      if (data.isNotEmpty) {
        emit(SendMessageState(messagesList: data));
      } else {
        emit(MessengerInit());
      }
    });
  }
}

class MessengerStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessengerInit extends MessengerStates {}

class SendMessageState extends MessengerStates {
  List<MessageModel> messagesList;

  SendMessageState({required this.messagesList});

  @override
  List<Object?> get props => [messagesList];
}
