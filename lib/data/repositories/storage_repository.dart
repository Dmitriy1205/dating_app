import 'dart:io';

import 'package:dating_app/data/data_provider/storage_data_provider.dart';

class StorageRepository {
  final StorageDataProvider storageProvider;

  StorageRepository({required this.storageProvider});

  Future<String> upload(File source, String destination) async {
    return await storageProvider.upload(source, destination);
  }

  Future<List<String>> getAll(String ref) async {
    return await storageProvider.getAll(ref);
  }
}
