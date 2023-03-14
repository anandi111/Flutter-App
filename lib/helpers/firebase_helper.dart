import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static final FirebaseHelper firebaseHelper = FirebaseHelper._();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['https://mail.google.com/']).signIn();
      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login(permissions: ["public_profile", "email"]);

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return firebaseAuth.signInWithCredential(facebookAuthCredential);
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOutFromFacebook() async {
    await firebaseAuth.signOut();
    return await _facebookAuth.logOut();
  }

  Future<String?> anonymousSignIn() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();

    User? user = userCredential.user;

    String uid = user!.uid;

    return uid;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(
          msg: "User not found",
          textColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Password is wrong",
          textColor: Colors.red,
        );
      }
      return null;
    }
  }

  Future<User?> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      return user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "The account already exists for that email.", textColor: Colors.red);
      } else {
        Fluttertoast.showToast(msg: "The password provided is too weak.", textColor: Colors.red);
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> changePasswordWithLink({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "User not found", textColor: Colors.red);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Invalid email", textColor: Colors.red);
      } else {
        Fluttertoast.showToast(msg: "Something seem wrong", textColor: Colors.red);
      }
    }
  }

  Future<void> changePasswordWithOutLink({
    required String newPassword,
  }) async {
    try {
      await firebaseAuth.currentUser!.updatePassword(newPassword);
      Fluttertoast.showToast(
          msg: "Password changed successfully", textColor: Colors.blue, gravity: ToastGravity.CENTER);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString(), textColor: Colors.red);
    }
  }
}
