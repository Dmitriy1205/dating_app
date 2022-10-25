import 'package:dating_app/data/models/hobbies.dart';
import 'package:dating_app/data/models/interests.dart';

class ProfileInfoData {
  String? name;
  String? bio;
  String? gender;
  String? height;
  String? age;
  String? university;
  String? degree;
  String? company;
  String? job;
  List<Hobbies>? hobbies;
  List<Interests>? interests;

  Map<String, dynamic> toMap() => {
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
