import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/exceptions.dart';
import '../models/message_model.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import '../models/search_pref_data.dart';

class FirebaseDataProvider {
  final FirebaseFirestore firestore;
  UserModel userModel = UserModel();
  MessageModel? messageModel;
  late String clearId;

  FirebaseDataProvider({required this.firestore});

  Future<void> createUser(
    User user,
    String name,
    String phone,
    String date,
    String joinDate,
    String email,
  ) async {
    userModel.id = user.uid;
    userModel.firstName = name;
    userModel.phone = phone;
    userModel.birthday = date;
    userModel.email = email;
    userModel.joinDate = joinDate;

    try {
      print(userModel.toFirestore());
      await firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toFirestore());
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setProfileFields(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection('users').doc(id).update({'ProfileInfo': data});
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<MessageModel?> sendMessageToPal(
      MessageModel messageModel, String chatId) async {
    try {
      print('irestore.collection(\'chats/chatId/messages\') ${chatId}');
      await firestore
          .collection('chats/$chatId/messages')
          .add(messageModel.toJson());

    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> clearChat(String chatId) async {
    try {
      final batch = firestore.batch();
      var collection = firestore.collection('chats/$chatId/messages');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      firestore.collection('chats').doc(chatId).set({'deleted': '${DateTime.now()}'});
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setSearchPreference(String id, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('users')
          .doc(id)
          .update({'SearchPreferences': data});
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> getLoggedUser() async {
    try {
      await firestore
          .collection('Users')
          .doc(userModel.id)
          .snapshots()
          .forEach((element) {
      });
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  String getClearChatId(String senderId, String recipientId) {
    int compareInt = senderId.compareTo(recipientId);
    String clearId = compareInt >= 0
        ? '${senderId}_$recipientId'
        : '${recipientId}_$senderId';
    return clearId;
  }

  Stream<List<MessageModel>> getAllChatMessagesStream(String chatId) =>
      firestore
          .collection('chats/$chatId/messages')
          .orderBy('time', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList());

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList =
          users.docs.map((user) => UserModel.fromJson(user.data())).toList();
      print('palls ${users}');
      return palsList;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<ProfileInfoFields?> getProfileFields(String id) async {
    try {
      final doc = await firestore
          .collection('ProfileInfo')
          .doc(id)
          .withConverter(
              fromFirestore: ProfileInfoFields.fromFirestore,
              toFirestore: (ProfileInfoFields d, _) => d.toFirestore())
          .get();
      return doc.data();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<UserModel?> getUserFields(String id) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(id)
          .withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel u, _) => u.toFirestore())
          .get();
      return doc.data();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<SearchPrefFields?> getSearchFields(String id) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(id)
          .withConverter(
              fromFirestore: SearchPrefFields.fromFirestore,
              toFirestore: (SearchPrefFields s, _) => s.toFirestore())
          .get();
      return doc.data();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> updateSearchFields(String id, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('users')
          .doc(id)
          .update({'SearchPreferences': data});
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  // Future<void> updateSearchFields(String id, Map<String, dynamic> data) async {
  //   try {
  //     await firestore
  //         .collection('SearchPreferences')
  //         .doc(id)
  //         .set(data, SetOptions(merge: true));
  //   } on FirebaseException catch (e) {
  //     print(e.message);
  //     throw BadRequestException(message: e.message!);
  //   }
  // }

  Future<void> updateProfileFields(String id, Map<String, dynamic> data) async {
    try {
      await firestore
          .collection('ProfileInfo')
          .doc(id)
          .set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> updateFields(
      String id, Map<String, dynamic> prof, Map<String, dynamic> look) async {
    try {
      await firestore.collection('users').doc(id).update({
        'ProfileInfo': prof,
        'SearchPreferences.lookingFor': look,
      });
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<ProfileInfoFields>> getAllFields() async {
    try {
      final doc = await firestore.collection('ProfileInfo').get();

      return doc.docs.map((e) => ProfileInfoFields.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<SearchPrefFields>> getAllSearchFields() async {
    try {
      final doc = await firestore.collection('SearchPreferences').get();

      return doc.docs.map((e) => SearchPrefFields.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<UserModel>> getAllUserFields() async {
    try {
      final doc = await firestore.collection('users').get();

      return doc.docs.map((e) => UserModel.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }
}
