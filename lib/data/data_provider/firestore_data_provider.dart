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
    String name,
    String phone,
    String date,
    String email,
  ) async {
    userModel.firstName = name;
    userModel.userId = user.uid;
    userModel.registrationDate = DateTime.now().toString();
    userModel.email = email;
    userModel.phoneNumber = phone;
    userModel.birthday = date;

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

  Future<MessageModel?> sendMessageToPal(
      MessageModel messageModel, chatId) async {
    try {
      await firestore
          .collection('chats/${chatId}/messages')
          .add(messageModel.toJson());

      print(' sendMessageToPal  $chatId');
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<MessageModel>> getAllChatMessages(String chatId) async {

    try {
      print('getAllChatMessages   $chatId');

      List<MessageModel> queryListMessages = await firestore
          .collection('chats/$chatId/messages').orderBy('time', descending: false)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((e) {
          print('eeeeeeeeee   queryListMessages ${e}');
          return MessageModel.fromJson(e.data() as Map<String, dynamic>);
        }).toList();
      });
      queryListMessages.forEach((element) {
        print('element ${element}');
      });

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
