import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.id,
      this.firstName,
      // this.lastName,
      this.phone,
      this.birthday,
      this.email,
      this.joinDate});

  String? id;
  String? firstName;

  // String? lastName;
  String? phone;
  String? birthday;
  String? email;
  String? joinDate;

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: data?['id'],
      birthday: data?['date'],
      email: data?['email'],
      joinDate: data?['joinDate'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['name'],
      // lastName: json['lastName'],
      phone: json['phone'],
      birthday: json['date'],
      email: json['email'],
      joinDate: json['joinDate'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': firstName,
        // 'lastName': lastName,
        'phone': phone,
        'date': birthday,
        'email': email,
        'joinDate': joinDate
      };
}
