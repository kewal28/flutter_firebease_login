import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebease_login/Screens/after_login_page.dart';
import 'package:flutter_firebease_login/Screens/login.dart';
import 'package:flutter_firebease_login/config.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    bool checkLogin = user != null ? true : false;
    if (checkLogin) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AfterLoginPage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _landing(),
    );
  }

  Widget _landing() {
    return SafeArea(
      child: Center(
        child: Text(
          Config.name,
          style: TextStyle(
            fontFamily: Config.fontFamily,
            fontSize: 40.0,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
