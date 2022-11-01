import 'package:dating_app/data/data_provider/firestore_data_provider.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;
  MessageModel? messageModel;
  DataRepository({required this.dataProvider});

  Future<void> setFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setGeneralFields(id, data);
  }
  Future<List<UserModel>> getPals()async {
    return await dataProvider.getUsers();
  }

  Future<MessageModel?> sendMessageToPal(messageModel)async {
    return await dataProvider.sendMessageToPal(messageModel);
  }

  Future<List<MessageModel>> getAllChatMessages(String chatId)async {
    return await dataProvider.getAllChatMessages(chatId);
  }

}
