import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/exceptions.dart';
import '../models/message_model.dart';

class FirebaseDataProvider {
  final FirebaseFirestore firestore;
  UserModel userModel = UserModel();
  MessageModel? messageModel;

  FirebaseDataProvider({required this.firestore});

  Future<void> createUser(
    User user,
    UserModel userModel
  ) async {
    try {
      await firestore.collection('users').doc(user.uid).set(userModel.toJson());
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> setGeneralFields(String id, Map<String, dynamic> data) async {
    try {
      await firestore.collection('ProfileInfo').doc(id).set(data);
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<MessageModel?> sendMessageToPal(MessageModel messageModel) async {
    try {
      await firestore
          .collection(
              'chats/${messageModel.recipientName}_${messageModel.senderName}/messages')
          .add(messageModel.toJson());

      print(
          'chats/${messageModel.recipientName}_${messageModel.senderName}/messages');
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<MessageModel>> getAllChatMessages(String chatId) async {
    try {
      print('chatIdchatId ${chatId}');

      List<MessageModel> queryListMessages = await firestore
          .collection('chats/$chatId/messages')
          .get()
          .then((QuerySnapshot querySnapshot) => querySnapshot.docs
              .map((e) =>
                  MessageModel.fromJson(e.data() as Map<String, dynamic>))
              .toList());
      // queryListMessages.forEach((element) {print('queryListMessages ${element.message})}');});

      return queryListMessages;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

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
}
