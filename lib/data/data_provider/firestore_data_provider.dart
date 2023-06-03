import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../core/exceptions.dart';
import '../models/friend_model.dart';
import '../models/message_model.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import '../models/search_pref_data.dart';
import 'package:ntp/ntp.dart';

class FirebaseDataProvider {
  final FirebaseFirestore firestore;
  UserModel userModel = UserModel();
  MessageModel? messageModel;
  late String clearId;

  FirebaseDataProvider({required this.firestore});

  Future<void> createUser({
    required User user,
    required String name,
    required String phone,
    required String date,
    required String joinDate,
    required String email,
    required String language,
  }) async {
    userModel.id = user.uid;
    userModel.firstName = name;
    userModel.phone = phone;
    userModel.birthday = date;
    userModel.email = email;
    userModel.joinDate = joinDate;
    userModel.language = language;

    try {
      if (kDebugMode) {
        print(userModel.toFirestore());
      }
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
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> sendMessageToPal(
      MessageModel messageModel, String chatId) async {
    DateTime dateTimeNow = await NTP.now();
    try {
      final String messageId =
          firestore.collection('chats/$chatId/messages').doc().id;
      messageModel.messageId = messageId;
      messageModel.time = dateTimeNow.toString();
      await firestore
          .collection('chats/$chatId/messages')
          .doc(messageId)
          .set(messageModel.toJson());
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
      firestore
          .collection('chats')
          .doc(chatId)
          .set({'deleted': '${DateTime.now()}'});
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
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> getLoggedUser() async {
    try {
      await firestore
          .collection('Users')
          .doc(userModel.id)
          .snapshots()
          .forEach((element) {});
    } on FirebaseException catch (e) {
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

  Future<List<UserModel>> getUsers({required String currentUserId}) async {
    List<String> listAddedToFriends = [];
    try {
      QuerySnapshot<Map<String, dynamic>> getAddedFriends = await firestore
          .collection('users/$currentUserId/addedFriends')
          .get()
          .then((value) => value);
      QuerySnapshot<Map<String, dynamic>> refusedFriends = await firestore
          .collection('users/$currentUserId/refusedFriends')
          .get();
      for (var element in getAddedFriends.docs) {
        listAddedToFriends.add(element.data()['addedFriend']);
      }
      for (var element in refusedFriends.docs) {
        listAddedToFriends.add(element.data()['addedFriend']);
      }
      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList = [];
      users.docs.map((user) {
        if (!listAddedToFriends.contains(user.id)) {
          palsList.add(UserModel.fromJson(user.data()));
        }
      }).toList();

      return palsList;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<UserModel>> getContacts({required String currentUserId}) async {
    List<String> listAddedToFriends = [];
    try {
      QuerySnapshot<Map<String, dynamic>> getAddedFriends = await firestore
          .collection('users/$currentUserId/addedFriends')
          .get();
      for (var element in getAddedFriends.docs) {
        if (element.data()['blockedFriend'] == false) {
          listAddedToFriends.add(element.data()['addedFriend']);
        }
      }
      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList = [];
      users.docs.map((user) {
        if (listAddedToFriends.contains(user.id)) {
          palsList.add(UserModel.fromJson(user.data()));
        }
      }).toList();
      return palsList;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<UserModel>> getBlockedContactsList({required String currentUserId}) async {
    List<String> listAddedToFriends = [];
    try {
      QuerySnapshot<Map<String, dynamic>> getAddedFriends = await firestore
          .collection('users/$currentUserId/addedFriends')
          .get();
      for (var element in getAddedFriends.docs) {
        if (element.data()['blockedFriend'] == true) {
          listAddedToFriends.add(element.data()['addedFriend']);
        }
      }
      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList = [];
      users.docs.map((user) {
        if (listAddedToFriends.contains(user.id)) {
          palsList.add(UserModel.fromJson(user.data()));
        }
      }).toList();
      return palsList;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> toBlockContact(String id,{required String currentUserId}) async {
    try {
      await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('addedFriends')
          .doc(id)
          .update({'blockedFriend': true});
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> toUnblockContact(String id,{required String currentUserId}) async {
    try {
      await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('addedFriends')
          .doc(id)
          .update({'blockedFriend': false});
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
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> updateFields(String id, Map<String, dynamic> prof,
      Map<String, dynamic> look, String name) async {
    try {
      await firestore.collection('users').doc(id).update({
        'ProfileInfo': prof,
        'SearchPreferences.lookingFor': look,
        'name': name,
      });
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<ProfileInfoFields>> getAllFields() async {
    try {
      final doc = await firestore.collection('ProfileInfo').get();

      return doc.docs.map((e) => ProfileInfoFields.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<SearchPrefFields>> getAllSearchFields() async {
    try {
      final doc = await firestore.collection('SearchPreferences').get();

      return doc.docs.map((e) => SearchPrefFields.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<UserModel>> getAllUserFields() async {
    try {
      final allUsers = await firestore.collection('users').get();

      return allUsers.docs.map((e) => UserModel.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> addedToFriends(String addedFriendId,{required String currentUserId}) async {
    try {
      await firestore
          .collection('users/$currentUserId/addedFriends')
          .doc(addedFriendId)
          .set(UserModel().addedFriendToFirestore(addedFriendId));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> refusedFriends(String refusedFriends,{required String currentUserId}) async {
    try {
      await firestore
          .collection('users/$currentUserId/refusedFriends')
          .doc(refusedFriends)
          .set(UserModel().addedFriendToFirestore(refusedFriends));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> palReadMessage(MessageModel message, String chatId) async {
    try {
      await firestore
          .collection('chats/$chatId/messages')
          .doc(message.messageId)
          .update({'isRead': true});
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<FriendModel?> isUserBlocked(
      String? currentUserId, String blockerUserId) async {
    try {
      var data = await firestore
          .collection('users')
          .doc(blockerUserId)
          .collection('addedFriends')
          .doc(currentUserId)
          .withConverter(
              fromFirestore: FriendModel.fromFirestore,
              toFirestore: (FriendModel u, _) => u.toFirestore())
          .get();

      return data.data();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<String>> isUserMatch(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await firestore
          .collection('users')
          .doc(id)
          .collection('addedFriends')
          .get();

      return data.docs.map((e) => e.id).toList();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getField(
      {required String collectionName, required String userId}) async {
    try {
      return await firestore.collection(collectionName).doc(userId).get();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.code);
    }
  }

  Future<void> saveToken({
    required String token,
    required String currentUserId,
  }) async {
    try {
      await firestore
          .collection('fcmTokens')
          .doc(currentUserId)
          .set({'token': token});
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }

  Future<void> saveField({
    required String collection,
    required String nameFieldToUpdate,
    required String userId,
    required String avatar,
    required String userName,
    required dynamic data,
  }) async {
    try {
      await firestore.collection(collection).doc(userId).set({
        'userId': userId,
        'avatar': avatar,
        'name': userName,
        nameFieldToUpdate: data
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw Exception(e.code.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCollectionById({
    required String collection,
    required String userId,
  }) async {
    try {
      final data = await firestore.collection(collection).doc(userId).get();
      return data;
    } on FirebaseException catch (e) {
      throw Exception(e.code.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllCollectionFields({
    required String collection,
  }) async {
    try {
      final data = await firestore.collection(collection).get();
      return data;
    } on FirebaseException catch (e) {
      throw Exception(e.code.toString());
    }
  }
}
