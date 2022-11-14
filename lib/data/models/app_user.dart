import 'package:cloud_firestore/cloud_firestore.dart';

class UserFields {
  final String? id;
  final String? birthDate;
  final String? email;
  final String? joinDate;

  UserFields({
    this.id,
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
      id: data?['id'],
      birthDate: data?['date'],
      email: data?['email'],
      joinDate: data?['joinDate'],
    );
  }

  factory UserFields.fromJson(Map<String, dynamic> json) {
    return UserFields(
      id: json['id'],
      birthDate: json['date'],
      email: json['email'],
      joinDate: json['joinDate'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'date': birthDate,
        'email': email,
        'joinDate': joinDate,
      };
}
