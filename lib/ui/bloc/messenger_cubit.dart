import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/service_locator.dart';
import '../../data/models/message_model.dart';
import '../../data/repositories/data_repository.dart';

class MessengerCubit extends Cubit<MessengerStates> {
  MessengerCubit() : super(MessengerInit());
  List<MessageModel> messagesList = [];
  Future<void> sendMessage(MessageModel messageModel) async {

    DataRepository db = sl();

    await db.sendMessageToPal(messageModel);
    messagesList.add(messageModel);
    print('${messageModel.message}');
    emit(SendMessageState(messagesList: messagesList));
    // messagesList.forEach((element) {element.message})}');
  }
}

class MessengerStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessengerInit extends MessengerStates {}

class SendMessageState extends MessengerStates {
  List<MessageModel> messagesList;

  SendMessageState({required this.messagesList}){
    print('messages from STATE   ${messagesList.length}');

  }

  @override
  List<Object?> get props => [double.nan];
}
