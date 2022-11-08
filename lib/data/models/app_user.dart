import 'package:cloud_firestore/cloud_firestore.dart';

class UserFields {
  final String? birthDate;
  final String? email;
  final String? joinDate;

  UserFields({
    this.birthDate,
    this.email,
    this.joinDate,
  });

  factory UserFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserFields(
      birthDate: data?['date'],
      email: data?['email'],
      joinDate: data?['joinDate'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': birthDate,
        'email': email,
        'joinDate': joinDate,
      };
}
