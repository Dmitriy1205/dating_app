import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;
  late String chatId;
  DataRepository({required this.dataProvider});

  Future<void> setProfileFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setProfileFields(id, data);
  }


  Future<List<UserModel>> getPals() async {
    return await dataProvider.getUsers();
  }

  Future<MessageModel?> sendMessageToPal(
      messageModel, String chatId) async {
    return await dataProvider.sendMessageToPal(messageModel, chatId);
  }

  String getClearId(recipientId, senderId) {
    print('recipientId $recipientId senderId $senderId');
    chatId = dataProvider.getClearChatId(senderId, recipientId);
    return chatId;
  }
  void clearChat(String chatId) {
    dataProvider.clearChat(chatId);
  }

  Stream<List<MessageModel>> getAllChatMessagesStream(
      String senderId, String recipientId)  {
    chatId = dataProvider.getClearChatId(senderId, recipientId);
    return dataProvider.getAllChatMessagesStream(chatId);
  }

  void getLoggedUser (){
    dataProvider.getLoggedUser();
  }

  Future<void> setSearchFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setSearchPreference(id, data);
  }

  // Future<ProfileInfoFields?> getProfileFields(String id) async {
  //   final fields = await dataProvider.getProfileFields(id);
  //   return fields;
  // }

  Future<UserModel?> getUserFields(String id) async {
    final fields = await dataProvider.getUserFields(id);
    return fields;
  }

  Future<SearchPrefFields?> getSearchFields(String id) async {
    final fields = await dataProvider.getSearchFields(id);
    return fields;
  }

  Future<void> updateSearchFields(String id, Map<String, dynamic> data) async {
    await dataProvider.updateSearchFields(id, data);
  }

  // Future<void> updateProfileFields(String id, Map<String, dynamic> data) async {
  //   await dataProvider.updateProfileFields(id, data);
  // }

  Future<void> updateFields(String id, Map<String, dynamic> profile,
      Map<String, dynamic> look) async {
    await dataProvider.updateFields(id, profile, look);
  }

  Future<List<ProfileInfoFields>> getAllFields() async {
    return dataProvider.getAllFields();
  }

  Future<List<SearchPrefFields>> getAllSearchFields() async {
    return dataProvider.getAllSearchFields();
  }

  Future<List<UserModel>> getAllUserFields() async {
    return dataProvider.getAllUserFields();
  }
}
