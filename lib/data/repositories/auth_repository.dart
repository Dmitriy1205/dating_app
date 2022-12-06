import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/exceptions.dart';
import '../data_provider/firestore_data_provider.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseDataProvider db;
  late UserModel userModel;

  AuthRepository({required this.db, required this.auth});

  Stream<User?> get authState => auth.authStateChanges();

  Future<void> signupWithPhone(
    String phoneNumber,
    String verificationId,
    void Function(String s) nav,
  ) async {
    try {
      print('phoneNumber  TRYYY signupWithPhone $phoneNumber');

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (verId, _) {
          verificationId = verId;
          nav(verificationId);
          print('print 1 $verificationId');
        },
        codeAutoRetrievalTimeout: (value) {},
      );
    } on FirebaseAuthException catch (e) {
      print('print 1 ${e.message.toString()}');
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> loginWithPhone(
    String phoneNumber,
    String verificationId,
    void Function(String s) nav,
  ) async {
    try {
      List<UserModel> allUsers = await db.getAllUserFields();
      final userPhone = allUsers.map((e) => e.phone);
      if (userPhone.contains(phoneNumber)) {
        await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (FirebaseAuthException e) {
            print('print  2 auth_repository login failed ${e.message}');
          },
          codeSent: (verId, _) {
            verificationId = verId;
            nav(verificationId);
            print('print 1 $verificationId');
          },
          codeAutoRetrievalTimeout: (value) {},
        );
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> verificationAfterSignUp(
    String verId,
    String code,
    String name,
    String phone,
    String date,
    String joinDate,
    String email,
    String language,
  ) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
      var signIn = await auth.signInWithCredential(credential);
      signIn;
      await db.createUser(
        signIn.user!,
        name,
        phone,
        date,
        email,
        joinDate,
        language,
      );
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> verificationAfterLogIn(
    String verId,
    String code,
  ) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: code);
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> loginWithApple() async {
    final rawNonce = generateNonce();
    final nonce = _sha256ofString(rawNonce);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      await auth.signInWithCredential(oauthCredential);
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      throw BadRequestException(message: 'Invalid access token');
    }

    try {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw BadRequestException(message: e.message!);
    } catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

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

  User? currentUser() {
    return auth.currentUser;
  }

  Stream<User?> getUserStatus() {
    return auth.userChanges();
  }

  Future<void> logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
