import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/message_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.db, this.auth) : super(MessengerInit()) {

  }
  final FirebaseAuth auth;
  List<MessageModel> messagesList = [];
  final DataRepository db;

  get currentUserId => auth.currentUser!.uid;

  Future<void> sendMessage(MessageModel messageModel, UserModel userModel) async {
    final String chatId = '${userModel.userId}_${currentUserId}';
    db.sendMessageToPal(messageModel, chatId);
    loadAllMessages(userModel);
    // emit(SendMessageState(messagesList: messagesList));
  }

  Future<void> loadAllMessages(UserModel userModel) async {
    print('userModel.userId MessengerCubit ${userModel.userId}_$currentUserId');
    List<MessageModel> messagesList =
        await db.getAllChatMessages('${userModel.userId}_$currentUserId');
    if (messagesList.isNotEmpty) {
      emit(SendMessageState(messagesList: messagesList));
    } else {
      emit(MessengerInit());
    }
  }
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
