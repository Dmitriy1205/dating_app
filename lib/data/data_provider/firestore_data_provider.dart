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
      await firestore.collection('users').doc(user.uid).set(userModel.toFirestore());
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setProfileFields(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection('ProfileInfo').doc(id).set(data);
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<MessageModel?> sendMessageToPal(
      MessageModel messageModel, chatId) async {
    print("collection('chats/${chatId}/messages')");
    try {
      await firestore
          .collection('chats/${chatId}/messages')
          .add(messageModel.toJson());

      print(' sendMessageToPal  $chatId');
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setSearchPreference(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection('SearchPreferences').doc(id).set(data);
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  String getClearChatId(String senderId, String recipientId) {
    int compareInt = senderId.compareTo(recipientId);
    // print('str STR : $compareInt');
    // print('str senderId : ${senderId.length}');
    // print('str recipientId : ${recipientId.length}');

    List<int> a = senderId.codeUnits;
    List<int> b = recipientId.codeUnits;
    //
    // int c = 0;
    // int d = 0;
    // for (int i in b) {
    //   print('int D = $d');
    //   d = d + i;
    // }
    // for (int i in a) {
    //   print('bbbb $c');
    //   c = c + i;
    // }
    String clearId = compareInt >= 0
        ? '${senderId}_$recipientId'
        : '${recipientId}_$senderId';
    return clearId;
  }

  // Future<List<MessageModel>> getAllChatMessages(String chatId) async {
  //   try {
  //     List<MessageModel> queryListMessages = await firestore
  //         .collection('chats/$chatId/messages')
  //         .orderBy('time', descending: false)
  //         .get()
  //         .then((QuerySnapshot querySnapshot) {
  //       return querySnapshot.docs.map((e) {
  //         return MessageModel.fromJson(e.data() as Map<String, dynamic>);
  //       }).toList();
  //     });
  //     queryListMessages.forEach((element) {
  //     });
  //
  //     return queryListMessages;
  //   } on FirebaseException catch (e) {
  //     throw BadRequestException(message: e.message!);
  //   }
  // }

  Stream<List<MessageModel>> getAllChatMessagesStream(String chatId) =>
      firestore
          .collection('chats/$chatId/messages')
          .orderBy('time', descending: false)
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
      print('${palsList.length}  palls ${palsList[0].firstName} ');
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
          .collection('SearchPreferences')
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
          .collection('SearchPreferences')
          .doc(id)
          .set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

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
