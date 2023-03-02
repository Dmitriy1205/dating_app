import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPrefFields {
  Map<String, dynamic>? yearsRange;
  int? distance;
  Map<String, dynamic>? lookingFor;
  String? gender;
  Map<String, dynamic>? hobbies;
  Map<String, dynamic>? interests;

  SearchPrefFields({
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
      yearsRange: data?['yearsRange'] ?? {'start': 20, 'end': 30},
      distance: data?['distance'] ?? 28,
      lookingFor: data?['lookingFor'] ??
          {
            'someone to chill with': false,
            'a friend': false,
            'a romantic partner': false,
            'a business partner': false,
            'a mentor': false,
            'a mentee': false
          },
      gender: data?['gender'] ?? '',
      hobbies: data?['hobbies'] ??
          {
            'WorkingOut': true,
            'Hiking': true,
            'Biking': true,
            'Shopping': true,
            'Cooking': true,
            'Baking': true,
            'Drinking': true,
            'Reading': true,
          },
      interests: data?['interests'] ??
          {
            'Politics': true,
            'Fashion': true,
            'FinArt': true,
            'Music': true,
            'Dance': true,
            'Film': true,
            'Photography': true,
            'Acting': true,
          },
    );
  }

  factory SearchPrefFields.fromJson(Map<String, dynamic> json) {
    return SearchPrefFields(
      yearsRange: json['yearsRange'] ?? {'start': 20, 'end': 30},
      distance: json['distance'] ?? 28,
      lookingFor: json['lookingFor'] ??
          {
            'someone to chill with': false,
            'a friend': false,
            'a romantic partner': false,
            'a business partner': false,
            'a mentor': false,
            'a mentee': false
          },
      gender: json['gender'] ?? '',
      hobbies: json['hobbies'] ??
          {
            'WorkingOut': true,
            'Hiking': true,
            'Biking': true,
            'Shopping': true,
            'Cooking': true,
            'Baking': true,
            'Drinking': true,
            'Reading': true,
          },
      interests: json['interests'] ??
          {
            'Politics': true,
            'Fashion': true,
            'FinArt': true,
            'Music': true,
            'Dance': true,
            'Film': true,
            'Photography': true,
            'Acting': true,
          },
    );
  }

  Map<String, dynamic> toFirestore() => {
        'yearsRange': yearsRange,
        'distance': distance,
        'lookingFor': lookingFor,
        'gender': gender,
        'hobbies': hobbies,
        'interests': interests,
      };
}
