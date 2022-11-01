import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfoFields {
  String? name;
  String? bio;
  String? gender;
  String? height;
  String? age;
  String? university;
  String? degree;
  String? company;
  String? job;
  Map<String, dynamic>? hobbies;
  Map<String, dynamic>? interests;

  ProfileInfoFields(
      {this.name,
      this.bio,
      this.gender,
      this.height,
      this.age,
      this.university,
      this.degree,
      this.company,
      this.job,
      this.hobbies,
      this.interests});

  factory ProfileInfoFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProfileInfoFields(
      name: data?['name'],
      bio: data?['bio'],
      gender: data?['gender'],
      height: data?['height'],
      age: data?['age'],
      university: data?['university'],
      degree: data?['degree'],
      company: data?['company'],
      job: data?['job'],
      hobbies: data?['hobbies'],
      interests: data?['interests'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'bio': bio,
        'gender': gender,
        'height': height,
        'age': age,
        'university': university,
        'degree/major': degree,
        'company': company,
        'job': job,
        'hobbies': hobbies,
        'interests': interests,
      };
}
