import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/exceptions.dart';

class FirebaseDataProvider {
  final FirebaseFirestore firestore;

  FirebaseDataProvider(this.firestore);

  Future<void> createUser(
    User user,
    String name,
    String phone,
    String date,
    String email,
  ) async {
    try {
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': phone,
        'date': date,
        'email': email,
      });
    } on FirebaseException catch (e) {
      throw BadRequestException(message: e.message!);
    }
  }

  Future<void> update() async {}
}
