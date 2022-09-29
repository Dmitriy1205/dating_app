import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/exceptions.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  Future<void> signupWithPhone() async {
    await auth.verifyPhoneNumber(
      verificationCompleted: (value) {},
      verificationFailed: (value) {},
      codeSent: (d, a) {},
      codeAutoRetrievalTimeout: (value) {},
    );
  }

  Future<void> loginWithPhone() async {}

  Future<void> loginWithApple() async {}

  Future<void> loginWithFacebook() async {}

  Future<void> loginWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }
}
