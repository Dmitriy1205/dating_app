import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPrefFields {
  Map<String, dynamic>? yearsRange;
  int? distance;
  Map<String, dynamic>? lookingFor;
  String? gender;

  SearchPrefFields({
    this.yearsRange,
    this.distance,
    this.lookingFor,
    this.gender,
  });

  factory SearchPrefFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SearchPrefFields(
      yearsRange: data?['yearsRange'],
      distance: data?['distance'],
      lookingFor: data?['lookingFor'],
      gender: data?['gender'],
    );
  }

  factory SearchPrefFields.fromJson(Map<String, dynamic> json) {
    return SearchPrefFields(
      yearsRange: json['yearsRange'],
      distance: json['distance'],
      lookingFor: json['lookingFor'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'yearsRange': yearsRange,
        'distance': distance,
        'lookingFor': lookingFor,
        'gender': gender,
      };
}
