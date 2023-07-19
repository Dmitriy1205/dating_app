import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/models/profile_info_data.dart';
import 'package:dating_app/data/models/search_pref_data.dart';

class UserModel {
  UserModel(
      {this.id,
      this.firstName,
      this.phone,
      this.birthday,
      this.email,
      this.joinDate,
      this.profileInfo,
      this.searchPref,
      this.language,
      this.isOnline,
      this.lastTimeOnline});

  String? id;
  String? firstName;
  String? phone;
  String? birthday;
  String? email;
  String? joinDate;
  List<String>? addedFriends;
  List<String>? blockedFriends;
  ProfileInfoFields? profileInfo;
  SearchPrefFields? searchPref;
  String? language;
  bool? isOnline;
  String? lastTimeOnline;

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
        firstName: data?['name'],
        phone: data?['phone'],
        isOnline: data?['isOnline'],
        lastTimeOnline: data?['lastTimeOnline']);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['name'],
        phone: json['phone'],
        birthday: json['date'],
        email: json['email'],
        joinDate: json['joinDate'],
        profileInfo: json['ProfileInfo'] == null
            ? null
            : ProfileInfoFields.fromJson(json['ProfileInfo']),
        searchPref: json['SearchPreferences'] == null
            ? null
            : SearchPrefFields.fromJson(json['SearchPreferences']),
        language: json['language'],
        isOnline: json['isOnline'],
        lastTimeOnline: json['lastTimeOnline']);
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': firstName,
        'phone': phone,
        'date': birthday,
        'email': email,
        'joinDate': joinDate,
        'ProfileInfo': profileInfo,
        'SearchPreferences': searchPref,
        'language': language,
        'isOnline': isOnline,
        'lastTimeOnline': lastTimeOnline
      };

  Map<String, dynamic> addedFriendToFirestore(String addedFriendId) =>
      {'addedFriend': addedFriendId, 'blockedFriend': false};

  Map<String, dynamic> blockFriendToFirestore(String addedFriendId) =>
      {'blockedFriend': true};
}
