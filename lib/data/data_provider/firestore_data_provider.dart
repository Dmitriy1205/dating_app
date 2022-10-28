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
    try {
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': phone,
        'date': date,
        'email': email,
      });
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
          .collection('Messages')
          .doc('${messageModel.recipientName}' + '${messageModel.senderName}')
          .set(messageModel.toJson());
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
