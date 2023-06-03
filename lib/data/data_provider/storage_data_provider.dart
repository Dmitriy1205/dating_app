import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../core/exceptions.dart';

class StorageDataProvider {
  final FirebaseStorage storage;

  StorageDataProvider({required this.storage});

  Future<String> upload(Uint8List file, String destination) async {
    try {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      UploadTask task = storage.ref(destination).putData(file, metadata);
      await task;
      return await task.snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }

  Future<List<String>> getAllById(String id) async {
    try {
      var images = await storage.ref('users/$id').listAll();

      List<String> data = [];
      for (int i = 0; i < images.items.length; i++) {
        String url = await images.items[i].getDownloadURL();
        data.add(url);
      }

      return data;
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }
}
