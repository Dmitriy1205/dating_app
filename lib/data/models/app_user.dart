import 'package:cloud_firestore/cloud_firestore.dart';

class UserFields {
  final String? birthDate;
  final String? email;

  UserFields({
    this.birthDate,
    required this.email,
  });

  factory UserFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserFields(
      birthDate: data?['date'],
      email: data?['email'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': birthDate,
        'email': email,
      };
}
