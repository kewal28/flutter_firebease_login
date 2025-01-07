import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebease_login/Models/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static getFormField(String hint, validation, controller, Icon icon,
      {keyboardType, bool obscureText = false, suffixIcon}) {
    var validations = checkValidation(validation, hint);
    return TextFormField(
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 18.0,
        color: Config.baseColor,
      ),
      validator: validations,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        prefixIcon: icon,
        hintText: hint,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Config.baseColor, width: 32.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      autofocus: false,
      controller: controller,
      keyboardType: keyboardType,
      onSaved: (value) {
        controller.text = value;
      },
      textInputAction: TextInputAction.next,
    );
  }

  static checkValidation(String validation, String hint) {
    if (validation == "email") {
      return (value) {
        if (value.isEmpty) {
          return 'Email cannot be empty';
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      };
    } else if (validation == "password") {
      return (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value.isEmpty) {
          return ("Password is required.");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
      };
    } else if (validation == "phone") {
      return (value) {
        RegExp regex = RegExp(r'^-?[0-9]+$');
        if (value.isEmpty) {
          return ("Phone no is required.");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Phone No.");
        }
        int length = '$value'.length; // 7
        if (length != 10) {
          return ("Phone No. is not valid.");
        }
      };
    } else if (validation == "required") {
      return (value) {
        if (value.isEmpty) {
          return (hint + " field is required.");
        }
      };
    } else {
      return (value) {};
    }
  }

  static getFormButton(String text, {onPress = null}) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Config.baseColorDart),
      ),
      label: Text(text),
      icon: const Icon(
        Icons.arrow_right,
        color: Colors.white,
      ),
      onPressed: onPress,
    );
  }

  static getAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(Config.name,
          style: TextStyle(
            fontFamily: Config.fontFamily,
            fontSize: 20,
            letterSpacing: 1,
            color: Config.baseColor,
          )),
      backgroundColor: Colors.white,
    );
  }

  static trimText(String text, int length) {
    if (text.length > length) {
      return text.substring(0, length) + " ...";
    } else {
      return text;
    }
  }

  //Print Toast
  printToast(String errorMsg) {
    Fluttertoast.showToast(
        msg: errorMsg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[500],
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static apiError() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      child: const Text("Error while Geting Error"),
    );
  }

  static notResultFound(context) {
    Utils utils = Utils();
    MediaQueryData width = utils.getWidth(context);
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width.size.width - 50,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/not-found.png"),
            Text(
              "Not created product yet.",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: Config.fontFamily,
                  // decoration: TextDecoration.underline,
                  color: Config.baseColor),
            ),
            Text(
              "You can create new product by clicking on add button below.",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: Config.fontFamily,
                  // decoration: TextDecoration.underline,
                  color: Config.baseColor),
            )
          ],
        ),
      ),
    );
  }

  MediaQueryData getWidth(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return queryData;
  }

  bool checkUserLogin(context) {
    User? user = FirebaseAuth.instance.currentUser;
    bool checkLogin = user != null ? true : false;
    return checkLogin;
  }

  getLoginUser(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    UserModel? loggedInUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser;
  }

  getTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  Future<void> alertBox({title, body, context, onPress}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(body),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: onPress,
            ),
          ],
        );
      },
    );
  }
}
