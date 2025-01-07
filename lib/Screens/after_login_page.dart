import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebease_login/Models/user.dart';
import 'package:flutter_firebease_login/Screens/login.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AfterLoginPage extends StatefulWidget {
  const AfterLoginPage({super.key});

  @override
  State<AfterLoginPage> createState() => _AfterLoginPageState();
}

class _AfterLoginPageState extends State<AfterLoginPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser;
  String name = "Guest";
  String email = "guest@gmail.com";

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      name = loggedInUser!.name;
      email = loggedInUser!.email;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "After Login page",
                style: TextStyle(
                  fontFamily: Config.fontFamily,
                  fontSize: 30.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: Config.fontFamily,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontFamily: Config.fontFamily,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
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
      Fluttertoast.showToast(msg: error.message!);
    }
  }
}
