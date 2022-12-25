import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/exceptions.dart';
import '../../core/service_locator.dart';
import '../models/message_model.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import '../models/search_pref_data.dart';
import '../repositories/user_repository.dart';

class FirebaseDataProvider {
  final FirebaseFirestore firestore;
  UserModel userModel = UserModel();
  MessageModel? messageModel;
  late String clearId;
  UserRepository userRepository = sl<UserRepository>();

  FirebaseDataProvider({required this.firestore});

  Future<void> createUser(
    User user,
    String name,
    String phone,
    String date,
    String joinDate,
    String email,
    String language,
  ) async {
    userModel.id = user.uid;
    userModel.firstName = name;
    userModel.phone = phone;
    userModel.birthday = date;
    userModel.email = email;
    userModel.joinDate = joinDate;
    userModel.language = language;

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

  Future<void> sendMessageToPal(
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
          .forEach((element) {});
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
    List<String> listAddedToFriends = [];
    try {
      QuerySnapshot<Map<String, dynamic>> getAddedFriends = await firestore
          .collection('users/${userRepository.getLoggedUser.id}/addedFriends')
          .get().then((value) => value);
      QuerySnapshot<Map<String, dynamic>> refusedFriends = await firestore
          .collection('users/${userRepository.getLoggedUser.id}/refusedFriends')
          .get();
      for (var element in getAddedFriends.docs) {
          listAddedToFriends.add(element.data()['addedFriend']);
      }
      print('refusedFriends ${refusedFriends.size}');

        for (var element in refusedFriends.docs) {
        print('element ${element.id}');
        listAddedToFriends.add(element.data()['addedFriend']);
      }
      print('listAddedToFriends ${listAddedToFriends.length}');

      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList = [];
      users.docs.map((user) {
        listAddedToFriends.contains(user.id)
            ? null
            : palsList.add(UserModel.fromJson(user.data()));
      }).toList();
      return palsList;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<List<UserModel>> getContacts() async {
    List<String> listAddedToFriends = [];
    try {
      QuerySnapshot<Map<String, dynamic>> getAddedFriends = await firestore
          .collection('users/${userRepository.getLoggedUser.id}/addedFriends')
          .get();
      getAddedFriends.docs.forEach((element) {
        if (element.data()['blockedFriend'] == false) {
          listAddedToFriends.add(element.data()['addedFriend']);
        }
      });
      QuerySnapshot<Map<String, dynamic>> users =
          await firestore.collection('users').get();
      List<UserModel> palsList = [];
      users.docs.map((user) {
        if (listAddedToFriends.contains(user.id))
             palsList.add(UserModel.fromJson(user.data()));
      }).toList();
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
      String id, Map<String, dynamic> prof, Map<String, dynamic> look,String name) async {
    try {
      await firestore.collection('users').doc(id).update({
        'ProfileInfo': prof,
        'SearchPreferences.lookingFor': look,
        'name':name,
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
      final allUsers = await firestore.collection('users').get();

      return allUsers.docs.map((e) => UserModel.fromJson(e.data())).toList();
    } on FirebaseException catch (e) {
      print(e.message);
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> addedToFriends(String addedFriendId) async {
    try {
      print('addedFriendId  ${addedFriendId}');
      print(
          'userRepository.getLoggedUser.id()  ${userRepository.getLoggedUser.id}');

      await firestore
          .collection('users/${userRepository.getLoggedUser.id}/addedFriends')
          .doc(addedFriendId)
          .set(UserModel().addedFriendToFirestore(addedFriendId));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> refusedFriends(String refusedFriends) async {
    try {
      print('addedFriendId  ${refusedFriends}');
      print(
          'userRepository.getLoggedUser.id()  ${userRepository.getLoggedUser.id}');

      await firestore
          .collection('users/${userRepository.getLoggedUser.id}/refusedFriends')
          .doc(refusedFriends)
          .set(UserModel().addedFriendToFirestore(refusedFriends));
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }
}
