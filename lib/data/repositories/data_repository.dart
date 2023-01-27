import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import '../models/friend_model.dart';
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

  Future<List<UserModel>> getContacts() async {
    return await dataProvider.getContacts();
  }

  Future<List<UserModel>> getBlockedContacts() async {
    return await dataProvider.getBlockedContactsList();
  }

  Future<void> blockContact(String id) async {
    await dataProvider.toBlockContact(id);
  }

  Future<void> unblockContact(String id) async {
    await dataProvider.toUnblockContact(id);
  }

  Future<void> sendMessageToPal(messageModel, String chatId) async {
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
      String senderId, String recipientId) {
    chatId = dataProvider.getClearChatId(senderId, recipientId);
    return dataProvider.getAllChatMessagesStream(chatId);
  }

  void getLoggedUser() {
    dataProvider.getLoggedUser();
  }

  Future<void> setSearchFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setSearchPreference(id, data);
  }

  Future<UserModel?> getUserFields(String id) async {
    final fields = await dataProvider.getUserFields(id);
    return fields;
  }

  Future<void> updateSearchFields(String id, Map<String, dynamic> data) async {
    await dataProvider.updateSearchFields(id, data);
  }

  Future<void> updateFields(String id, Map<String, dynamic> profile,
      Map<String, dynamic> look, String name) async {
    await dataProvider.updateFields(id, profile, look, name);
  }

  Future<List<UserModel>> getAllUserFields() async {
    return dataProvider.getAllUserFields();
  }

  Future<void> palReadMessage(MessageModel message) async {
    dataProvider.palReadMessage(message, chatId);
  }

  Future<FriendModel?> isUserBlocked(
      String? currentUserId, String blockerUserId) async {
    return dataProvider.isUserBlocked(currentUserId, blockerUserId);
  }

// Future<SearchPrefFields?> getSearchFields(String id) async {
//   final fields = await dataProvider.getSearchFields(id);
//   return fields;
// }

// Future<void> updateProfileFields(String id, Map<String, dynamic> data) async {
//   await dataProvider.updateProfileFields(id, data);
// }

// Future<ProfileInfoFields?> getProfileFields(String id) async {
//   final fields = await dataProvider.getProfileFields(id);
//   return fields;
// }
// Future<List<ProfileInfoFields>> getAllFields() async {
//   return dataProvider.getAllFields();
// }
//
// Future<List<SearchPrefFields>> getAllSearchFields() async {
//   return dataProvider.getAllSearchFields();
// }

}
