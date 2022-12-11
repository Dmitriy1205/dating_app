import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfoFields {
  // String? id;
  String? name;
  String? bio;
  String? image;
  String? gender;
  String? height;
  String? age;
  String? university;
  String? degree;
  String? company;
  String? status;
  String? job;
  Map<String, dynamic>? hobbies;
  Map<String, dynamic>? interests;
  String? location;

  ProfileInfoFields({
    // this.id,
    this.name,
    this.bio,
    this.image,
    this.gender,
    this.height,
    this.age,
    this.status,
    this.university,
    this.degree,
    this.company,
    this.job,
    this.hobbies,
    this.interests,
    this.location,
  });

  factory ProfileInfoFields.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProfileInfoFields(
      // id: data?['id'],
      name: data?['name'],
      bio: data?['bio'],
      image: data?['image'],
      gender: data?['gender'],
      height: data?['height'],
      age: data?['age'],
      university: data?['university'],
      degree: data?['degree/major'],
      company: data?['company'],
      job: data?['job'],
      hobbies: data?['hobbies'],
      interests: data?['interests'],
      status: data?['status'],
      location: data?['location'],
    );
  }

  factory ProfileInfoFields.fromJson(Map<String, dynamic> json) {
    return ProfileInfoFields(
      // id: json['id'],
      name: json['name'],
      bio: json['bio'],
      image: json['image'],
      gender: json['gender'],
      height: json['height'],
      age: json['age'],
      university: json['university'],
      degree: json['degree/major'],
      company: json['company'],
      job: json['job'],
      hobbies: json['hobbies'],
      interests: json['interests'],
      status: json['status'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        // 'id': id,
        'name': name,
        'bio': bio,
        'image': image,
        'gender': gender,
        'height': height,
        'age': age,
        'university': university,
        'degree/major': degree,
        'company': company,
        'job': job,
        'hobbies': hobbies,
        'interests': interests,
        'status': status,
        'location': location,
      };
}
