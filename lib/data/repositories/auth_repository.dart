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

  AuthRepository({required this.db, required this.auth});

  Future<void> signupWithPhone(
      String phoneNumber, String verificationId, void Function(String s) nav,
      {required Function() loaded}) async {
    try {
      List<UserModel> allUsers = await db.getAllUserFields();
      final userPhone = allUsers.map((e) => e.phone);
      if (!userPhone.contains(phoneNumber)) {
        await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (verId, _) {

            verificationId = verId;
            nav(verificationId);
            loaded();
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

  Future<void> loginWithPhone(
    String phoneNumber,
    String verificationId,
    void Function(String s) nav, {
    required void Function() loaded,
  }) async {
    try {
      List<UserModel> allUsers = await db.getAllUserFields();
      final userPhone = allUsers.map((e) => e.phone).toList();
      if (userPhone.contains(phoneNumber)) {
        try {
          await auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (_) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (verId, _) {

              verificationId = verId;
              nav(verificationId);
              loaded;
            },
            codeAutoRetrievalTimeout: (value) {},
          );
        } on Exception catch (e) {
          print(e.toString());
        }
      } else {
        loaded;
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      loaded;
      throw BadRequestException(message: e.message!);
    } catch (e) {
      loaded;
      throw BadRequestException(message: e.toString());
    }
  }

  Future<void> verificationAfterSignUp({
    required String verId,
    required String code,
    required String name,
    required String phone,
    required String date,
    required String email,
    required String joinDate,
    required String language,
  }) async {
    try {
      PhoneAuthCredential credential =
      PhoneAuthProvider.credential(verificationId: verId, smsCode: code);

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: 'password');


      var signIn =await userCredential.user!.linkWithCredential(credential);
      // var signIn = await auth.signInWithCredential(credential);
      // signIn;
      await db.createUser(
        user: signIn.user!,
        name: name,
        phone: phone,
        date: date,
        joinDate: joinDate,
        email: email,
        language: language,
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
      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(appleCredential.email!);
      if (signInMethods.isNotEmpty) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: appleCredential.email!, password: 'password');
        await userCredential.user?.linkWithCredential(oauthCredential);
        await auth.signInWithCredential(oauthCredential);
      } else {
        throw BadRequestException(message: '-');
      }
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
      final userData = await FacebookAuth.instance.getUserData(
        fields: 'email',
      );
      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(userData['email']);
      if (signInMethods.isNotEmpty) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: userData['email'], password: 'password');
        await userCredential.user?.linkWithCredential(facebookAuthCredential);
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {
        throw BadRequestException(message: '-');
      }
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
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      List<String> signInMethods =
          await auth.fetchSignInMethodsForEmail(googleUser.email);
      if (signInMethods.isNotEmpty) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: googleUser.email, password: 'password');
        await userCredential.user?.linkWithCredential(googleCredential);
        await auth.signInWithCredential(googleCredential);
      } else {
        throw BadRequestException(message: '-');
      }
    } on FirebaseAuthException catch (e) {
      if(e.toString() == '[firebase_auth/provider-already-linked] [ERROR_PROVIDER_ALREADY_LINKED] - User can only be linked to one identity for the given provider.'){
        return;
      }
      throw BadRequestException(message: e.message!);
    } on Exception catch (e) {
      throw BadRequestException(message: e.toString());
    }
  }

  User? currentUser() {
    return auth.currentUser;
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
