import 'dart:math';
import 'dart:typed_data';

import 'package:dating_app/core/exceptions.dart';
import 'package:dating_app/data/data_provider/storage_data_provider.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:intl/intl.dart';

import '../data_provider/firestore_data_provider.dart';
import '../models/story.dart';

class StoriesRepository {
  final StorageDataProvider _storage;
  final FirebaseDataProvider _firestore;

  StoriesRepository({
    required StorageDataProvider storage,
    required FirebaseDataProvider firestore,
  })  : _storage = storage,
        _firestore = firestore;

  Future<void> publishStory({
    required Uint8List file,
    required String currentUserId,
  }) async {
    try {
      List<dynamic>? data = [];
      DateTime now = DateTime.now();

      final usersSnapshot = await _firestore.getCollectionById(
          collection: 'users', userId: currentUserId);
      final UserModel userModel = UserModel.fromJson(usersSnapshot.data()!);

      final String image = await _storage.upload(
          file, 'stories/$currentUserId/image${generateName()}.png');
      String formattedDate = DateFormat('dd,MMMM,yyyy').format(now);

      final snapshot = await _firestore.getCollectionById(
        collection: 'allStories',
        userId: currentUserId,
      );
      if (snapshot.exists) {
        data = snapshot.data()!['stories'] as List;
      }

      final story = {'image': image, 'date': formattedDate};
      data.add(story);

      await _firestore.saveField(
        collection: 'allStories',
        userId: currentUserId,
        nameFieldToUpdate: 'stories',
        data: data,
        userName: userModel.firstName ?? '',
        avatar: userModel.profileInfo?.image ?? '',
      );
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<List<Story>> getAllUsersStories() async {
    try {
      final snapshot =
          await _firestore.getAllCollectionFields(collection: 'allStories');
      return snapshot.docs.map((e) => Story.fromJson(e.data())).toList();
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<List<Stories>?> getCurrentUserStories({required String userId}) async {
    try {
      final snapshot = await _firestore.getCollectionById(
        collection: 'allStories',
        userId: userId,
      );
      if (!snapshot.exists) {
        return [];
      }
      return (snapshot.data()!['stories'] as List)
          .map((e) => Stories.fromJson(e))
          .toList();
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  String generateName() {
    final Random random = Random.secure();

    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const int charsLength = chars.length;

    String id = '';

    for (int i = 0; i < 6; i++) {
      id += chars[random.nextInt(charsLength)];
    }

    return id;
  }
}
