import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/exceptions.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  Future<void> signupWithPhone(
    String phoneNumber,
    String verificationId,
    Future<void> nav,
  ) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (verId, _) {
        verificationId = verId;
        nav;
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (value) {},
    );
  }

  Future<void> loginWithPhone(String phone) async {
    await auth.signInWithPhoneNumber(phone);
  }

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

  Future<void> logout() async {
    await auth.signOut();
  }
}
