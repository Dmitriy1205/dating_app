import 'package:dating_app/data/data_provider/firestore_data_provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;

  DataRepository({required this.dataProvider});

  Future<void> setFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setGeneralFields(id, data);
  }

  Future<List<UserModel>> getPals() async {
    return await dataProvider.getUsers();
  }

  Future<MessageModel?> sendMessageToPal(
      messageModel, recipientId, senderId) async {
    String chatId = dataProvider.getClearChatId(senderId, recipientId);
    return await dataProvider.sendMessageToPal(messageModel, chatId);
  }

  // Future<List<MessageModel>> getAllChatMessages(
  //     String senderId, String recipientId) async {
  //   String chatId = dataProvider.getClearChatId(senderId, recipientId);
  //   return await dataProvider.getAllChatMessages(chatId);
  // }
  Stream<List<MessageModel>> getAllChatMessagesStream(
      String senderId, String recipientId)  {
    String chatId = dataProvider.getClearChatId(senderId, recipientId);
    return dataProvider.getAllChatMessagesStream(chatId);
  }
}
