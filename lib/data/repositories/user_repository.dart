import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRepository({required this.firestore, required this.auth});

  UserModel loggedUser = UserModel();

  get getUserName {
    print('getter user ${loggedUser.firstName}');
    return loggedUser.firstName;}

  Future<void> userLoginRepo() async {
    print('users/${auth.currentUser!.uid}/');
    await firestore
        .collection('users')
        .doc('${auth.currentUser!.uid}')
        .get()
        .then((value) => loggedUser = UserModel.fromJson(value.data()!));
    print(' loggedUser UserRepository ${loggedUser.firstName}');
  }
}
