import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../core/exceptions.dart';

class StorageDataProvider {
  final FirebaseStorage storage;

  StorageDataProvider({required this.storage});

  Future<String> upload(File file, String destination) async {
    try {
      UploadTask task = storage.ref(destination).putFile(file);
      await task;
      return await task.snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message.toString());
    }
  }
}
