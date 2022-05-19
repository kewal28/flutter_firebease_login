import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebease_login/utils.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  Utils utils = Utils();
  @override
  Widget build(BuildContext context) {
    double width = 100;
    MediaQueryData mediaQuery;
    if (!kIsWeb) {
      mediaQuery = utils.getWidth(context);
      width = mediaQuery.size.width;
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: width,
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Privacy Policy page"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
