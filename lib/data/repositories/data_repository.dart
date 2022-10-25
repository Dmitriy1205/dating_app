import 'package:dating_app/data/data_provider/firestore_data_provider.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;

  DataRepository({required this.dataProvider});

  Future<void> setFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setGeneralFields(id, data);
  }
}
