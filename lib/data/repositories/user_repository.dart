import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data_provider/firestore_data_provider.dart';
import '../models/call_model.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDataProvider _firebaseDataProvider;

  UserRepository(
      {required this.firestore,
      required this.auth,
      required FirebaseDataProvider firebaseDataProvider})
      : _firebaseDataProvider = firebaseDataProvider;

  UserModel loggedUser = UserModel();
  late String loggedUserPicture;

  get getUserName {
    return loggedUser.firstName;
  }

  get getLoggedUser {
    return loggedUser;
  }

  Future<void> loggedUserPictureMethod() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      loggedUserPicture = value.data()!['ProfileInfo']['image'];
    });
  }

  Future<void> userLoginRepo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => loggedUser = UserModel.fromJson(value.data()!));
  }

  Future<List<CallModel>> getUserCallHistory() async {
    final calls =
        await _firebaseDataProvider.getAllCollectionFields(collection: 'calls');
    return calls.docs.map((e) => CallModel.fromJson(e.data())).toList();
  }
}
