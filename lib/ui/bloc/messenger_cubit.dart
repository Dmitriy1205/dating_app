import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/message_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit(this.userModel, this.db) : super(MessengerInit()) {
    loadAllMessages();
  }

  final UserModel userModel;
  List<MessageModel> messagesList = [];
  final DataRepository db;

  Future<void> sendMessage(MessageModel messageModel) async {
    db.sendMessageToPal(messageModel);

    emit(SendMessageState(messagesList: messagesList));
  }

  Future<void> loadAllMessages() async {
    List<MessageModel> messagesList =
        await db.getAllChatMessages('${userModel.firstName}');
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
  List<Object?> get props => [double.nan];
}
