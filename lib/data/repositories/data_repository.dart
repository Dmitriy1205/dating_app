import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/models/app_user.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';

class DataRepository {
  final FirebaseDataProvider dataProvider;

  DataRepository({required this.dataProvider});

  Future<void> setProfileFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setProfileFields(id, data);
  }

  Future<void> setSearchFields(String id, Map<String, dynamic> data) async {
    return dataProvider.setSearchPreference(id, data);
  }

  Future<ProfileInfoFields?> getProfileFields(String id) async {
    final fields = await dataProvider.getProfileFields(id);
    return fields;
  }

  Future<UserFields?> getUserFields(String id) async {
    final fields = await dataProvider.getUserFields(id);
    return fields;
  }

  Future<SearchPrefFields?> getSearchFields(String id) async {
    final fields = await dataProvider.getSearchFields(id);
    return fields;
  }
}
