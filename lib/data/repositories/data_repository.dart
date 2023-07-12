import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<UserModel>> getPals({required String currentUserId}) async {
    return await dataProvider.getUsers(currentUserId: currentUserId);
  }

  Future<List<UserModel>> getContacts({required String currentUserId}) async {
    return await dataProvider.getContacts(currentUserId: currentUserId);
  }

  Future<List<UserModel>> getBlockedContacts({required String currentUserId}) async {
    return await dataProvider.getBlockedContactsList(currentUserId: currentUserId);
  }

  Future<void> blockContact(String id,{required String currentUserId}) async {
    await dataProvider.toBlockContact(id, currentUserId: currentUserId);
  }

  Future<void> unblockContact(String id,{required String currentUserId}) async {
    await dataProvider.toUnblockContact(id, currentUserId: currentUserId);
  }

  Future<void> sendMessageToPal(messageModel, String chatId) async {
    return await dataProvider.sendMessageToPal(messageModel, chatId);
  }

  String getClearId(recipientId, senderId) {
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
    UserModel? fields = await dataProvider.getUserFields(id);
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

  Future<List<String>> isUserMatch(String id) async {
    return dataProvider.isUserMatch(id);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getField(
      {required String collectionName, required String userId}) async {
    return await dataProvider.getField(
        collectionName: collectionName, userId: userId);
  }

  Future<void> saveToken({
    required String token,
    required String currentUserId,
  }) async {
    await dataProvider.saveToken(token: token, currentUserId: currentUserId);
  }

}
