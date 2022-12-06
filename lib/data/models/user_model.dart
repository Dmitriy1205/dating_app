import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    // this.lastName,
    this.phone,
    this.birthday,
    this.email,
    this.joinDate,
    this.profileInfo,
    this.searchPref,
    this.language,
  });

  String? id;

  String? firstName;

  // String? lastName;
  String? phone;
  String? birthday;
  String? email;
  String? joinDate;

  ProfileInfoFields? profileInfo;
  SearchPrefFields? searchPref;

  String? language;

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
      profileInfo: ProfileInfoFields.fromJson(data?['ProfileInfo']),
      searchPref: SearchPrefFields.fromJson(data?['SearchPreferences']),
      language: data?['language'],
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
      profileInfo: ProfileInfoFields.fromJson(json['ProfileInfo']),
      searchPref: SearchPrefFields.fromJson(json['SearchPreferences']),
      language: json['language'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,

        'name': firstName,
        // 'lastName': lastName,
        'phone': phone,
        'date': birthday,
        'email': email,
        'joinDate': joinDate,
        'ProfileInfo': profileInfo,
        'SearchPreferences': searchPref,
        'language': language,
      };
}
