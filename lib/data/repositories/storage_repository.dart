import 'dart:typed_data';

import 'package:dating_app/data/data_provider/storage_data_provider.dart';

class StorageRepository {
  final StorageDataProvider storageProvider;

  StorageRepository({required this.storageProvider});

  Future<String> upload(Uint8List source, String destination) async {
    return await storageProvider.upload(source, destination);
  }

  Future<List<String>> getAllById(String id) async {
    return await storageProvider.getAllById(id);
  }
}
