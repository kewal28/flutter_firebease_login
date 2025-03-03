import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_firebease_login/Models/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late String errorMessage;

  singIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((uuid) => {
                print(uuid),
              });
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.message != null) {
        errorMessage = _errorMessage(error.code);
        Fluttertoast.showToast(msg: errorMessage);
      }
      return false;
    }
  }

  singUp(String email, String password, String name, String phone,
      String img) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((uuid) async {
        saveProfileData(name.trim(), phone, img);
        await singIn(email, password);
      });
      return true;
    } on FirebaseAuthException catch (error) {
      errorMessage = _errorMessage(error.code);
      Fluttertoast.showToast(msg: errorMessage);
      return false;
    }
  }

  void saveProfileData(name, phone, img) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }

    UserModel userModel = UserModel(uid: user.uid, email: user.email!, phone: phone, name: name, img: img);
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
      errorMessage = _errorMessage(error.code);
      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  String _errorMessage(code) {
    switch (code) {
      case "invalid-email":
        return "Your email address appears to be malformed.";
        break;
      case "wrong-password":
        return "Your password is wrong.";
        break;
      case "user-not-found":
        return "User with this email doesn't exist.";
        break;
      case "user-disabled":
        return "User with this email has been disabled.";
        break;
      case "too-many-requests":
        return "Too many requests";
        break;
      case "operation-not-allowed":
        return "Signing in with Email and Password is not enabled.";
        break;
      case "network-request-failed":
        return Config.noInternetMessage;
        break;
      default:
        return "An undefined Error happened.";
    }
  }
}
