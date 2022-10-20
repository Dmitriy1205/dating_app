import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/service_locator.dart';

class FirebaseDataProvider {
  final firestore = sl<FirebaseFirestore>();

  Future<void> createUser(String name, String date, String email) async {
    await firestore.collection('Users').doc().set({
      'name': name,
      'date': date,
      'email': email,
    });
  }

  Future<void> update() async {}
}
