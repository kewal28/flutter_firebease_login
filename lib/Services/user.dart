import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebease_login/Models/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String errorMessage;

  singIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((uuid) => {
                // print(uuid),
              });
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.message != null) {
        debugPrint(error.code);
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "email-already-in-use":
            errorMessage = "Email address already in use.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case "network-request-failed":
            errorMessage = Config.noInternetMessage;
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage);
      }
      return false;
    }
  }

  singUp(String email, String password, String name, String phone) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((uuid) async {
        saveProfileData(name.trim(), phone);
        await singIn(email, password);
      });
      return true;
    } on FirebaseAuthException catch (error) {
      debugPrint(error.code);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
          errorMessage = Config.noInternetMessage;
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      return false;
    }
  }

  void saveProfileData(name, phone) async {
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = name;
    userModel.phone = phone;

    await users.doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: Config.signUpMsg);
  }

  forgetPassword(email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((uuid) => {Fluttertoast.showToast(msg: Config.forgetMsg)});
      return true;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
          errorMessage = Config.noInternetMessage;
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }
}
