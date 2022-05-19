import 'package:flutter/material.dart';

class Config {
  static String name = "Flutter Firebase";
  static String fontFamily = "Poppins";
  static Color baseColor = const Color(0xFF4CAF50);
  static Color baseColorDart = const Color(0xFF3d8b40);
  static String loginMsg = "Login Successfully";
  static String signUpMsg = "Signup Successfully";
  static String logoutMsg = "Logout Successfully";
  static String forgetMsg = "Reset password link send on you Email id.";
  static String errorCal = "Something is wrong not anble to calculate";
  static String noInternetMessage = "No Internet Connection";

  static Widget appBar(context, title,
      {bool home = false, bool leading = true}) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: leading
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontFamily: Config.fontFamily,
          letterSpacing: 1,
          color: Colors.white,
        ),
      ),
      backgroundColor: Config.baseColor,
      actions: <Widget>[
        home
            ? IconButton(
                icon: const Icon(Icons.home),
                tooltip: 'Go Home',
                onPressed: () {},
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
