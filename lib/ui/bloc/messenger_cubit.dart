import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/message_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.db, this.auth, this.userModel) : super(MessengerInit()) {
    messagesStream();
    print('userModel constructor ${userModel.firstName}');
    print('messagesList length from constructor ${messagesList.length}');
  }

  final UserModel userModel;

  final FirebaseAuth auth;
  List<MessageModel> messagesList = [];
  final DataRepository db;

  get currentUserId => auth.currentUser!.uid;

  get currentUserName => auth.currentUser!.displayName;

  void sendMessage(MessageModel messageModel, UserModel userModel) async {
    messageModel.senderName = currentUserName;
    db.sendMessageToPal(messageModel, userModel.id, currentUserId);
    print('sendMessage ${messagesList.last}');

    // if (messagesList.isNotEmpty) {
    //   emit(SendMessageState(messagesList: messagesList));
    // } else {
    //   emit(MessengerInit());
    // }
  }

  void messagesStream() async {
    print('messagesStream ${userModel.firstName}');
    final messages = db
        .getAllChatMessagesStream(userModel.id.toString(), currentUserId)
        .listen((event) {
      print('stream used messagesStream  listen ${event}');
      // for (var element in event) {
      //   messagesList.add(element);
      // }
    });
    messages.onData((data) {

      if (data.isNotEmpty) {
        emit(SendMessageState(messagesList: data));
      } else {
        emit(MessengerInit());
      }
    });
    print('messagesList ${messagesList.runtimeType}   ${messagesList.length}');

  }
// Stream loadAllMessagesStream (UserModel userModel) async {
//   List<MessageModel> messagesList = [];
//   messagesList.add(messagesStream(userModel));
//   if (messagesList.isNotEmpty) {
//     emit(SendMessageState(messagesList: messagesList));
//   } else {
//     emit(MessengerInit());
//   }
//   return messagesList;
// }
}

class MessengerStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessengerInit extends MessengerStates {}

class SendMessageState extends MessengerStates {
  List<MessageModel> messagesList;

  SendMessageState({required this.messagesList}) {
    print('messages from SendMessageState ${messagesList.length}');
  }

  @override
  List<Object?> get props => [messagesList];
}
