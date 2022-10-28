import 'package:dating_app/data/data_provider/firestore_data_provider.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;

  DataRepository({required this.dataProvider});

  Future<void> setProfileFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setProfileFields(id, data);
  }

  Future<void> setSearchFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setSearchPreference(id, data);
  }
}
