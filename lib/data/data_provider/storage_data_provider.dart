import 'package:firebase_storage/firebase_storage.dart';

import '../../core/service_locator.dart';

class StorageDataProvider {
  final storage = sl<FirebaseStorage>();
}
