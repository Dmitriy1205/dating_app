import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/message_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.db, this.auth) : super(SendMessageState()) ;
  final FirebaseAuth auth;
  List<MessageModel> messagesList = [];
  final DataRepository db;

  get currentUserId => auth.currentUser!.uid;
  get currentUserName => auth.currentUser!.displayName;

  Future<void> sendMessage(MessageModel messageModel, UserModel userModel) async {
    messageModel.senderName = currentUserName;
    db.sendMessageToPal(messageModel, userModel.userId, currentUserId);
    messagesStream(userModel);
    // emit(SendMessageState(messagesList: messagesList));
  }

  // Future<void> loadAllMessages(UserModel userModel) async {
  //   List<MessageModel> messagesList =
  //       await db.getAllChatMessages(userModel.userId.toString(), currentUserId);
  //   if (messagesList.isNotEmpty) {
  //     emit(SendMessageState(messagesList: messagesList));
  //   } else {
  //     emit(MessengerInit());
  //   }
  // }



  Stream<List<MessageModel>> messagesStream(UserModel userModel){
    print ('stream used messagesStream');
    var a = db.getAllChatMessagesStream(userModel.userId.toString(), currentUserId);
    // var b = a.first.then((value) =>  value.forEach((element) {print('element.message ${element.message}');}));
    // print ('stream2 used messagesStream  ${b}');
    return a;
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

// class MessengerInit extends MessengerStates {}

class SendMessageState extends MessengerStates {
  // List<MessageModel> messagesList;

  SendMessageState(
      // {required this.messagesList}
      ) {
    // print('messages from SendMessageState ${messagesList.length}');
  }

  @override
  List<Object?> get props => [];
}
