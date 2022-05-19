import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebease_login/Screens/login.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AfterLoginPage extends StatefulWidget {
  AfterLoginPage({Key key}) : super(key: key);

  @override
  State<AfterLoginPage> createState() => _AfterLoginPageState();
}

class _AfterLoginPageState extends State<AfterLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "After Login page",
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Config.baseColorDart),
                ),
                child: const Text("Logout"),
                onPressed: () async {
                  logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        Fluttertoast.showToast(msg: Config.logoutMsg);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      });
    } on FirebaseAuthException catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.message);
    }
  }
}
