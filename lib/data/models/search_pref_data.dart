import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPrefFields {
  String? id;
  Map<String, dynamic>? yearsRange;
  int? distance;
  Map<String, dynamic>? lookingFor;
  String? gender;
  Map<String, dynamic>? hobbies;
  Map<String, dynamic>? interests;

  SearchPrefFields({
    this.id,
    this.yearsRange,
    this.distance,
    this.lookingFor,
    this.gender,
    this.hobbies,
    this.interests,
  });

  factory SearchPrefFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SearchPrefFields(
      id: data?['id'],
      yearsRange: data?['yearsRange'],
      distance: data?['distance'],
      lookingFor: data?['lookingFor'],
      gender: data?['gender'],
      hobbies: data?['hobbies'],
      interests: data?['interests'],
    );
  }

  factory SearchPrefFields.fromJson(Map<String, dynamic> json) {
    return SearchPrefFields(
      id: json['id'],
      yearsRange: json['yearsRange'],
      distance: json['distance'],
      lookingFor: json['lookingFor'],
      gender: json['gender'],
      hobbies: json['hobbies'],
      interests: json['interests'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'yearsRange': yearsRange,
        'distance': distance,
        'lookingFor': lookingFor,
        'gender': gender,
        'hobbies': hobbies,
        'interests': interests,
      };
}
