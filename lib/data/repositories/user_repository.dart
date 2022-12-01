import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRepository({required this.firestore, required this.auth});

  UserModel loggedUser = UserModel();
  late String loggedUserPicture;

  get getUserName {
    return loggedUser.firstName;
  }

  get getLoggedUserProfilePicture {
    return loggedUserPicture;
  }

  Future<void> loggedUserPictureMethod() async {
    await firestore
        .collection('ProfileInfo')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
          print('value loggedUserPicture ${value.data()}');
      loggedUserPicture = value.data()!['image'];
    });

  }

  Future<void> userLoginRepo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => loggedUser = UserModel.fromJson(value.data()!));
    print(' loggedUser UserRepository ${loggedUser.firstName}');
    print(' loggedUserid UserRepository ${loggedUser.id}');

  }
}
