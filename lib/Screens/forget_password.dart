import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firebease_login/Screens/login.dart';
import 'package:flutter_firebease_login/Services/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:flutter_firebease_login/utils.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  UserService userService = UserService();
  Utils utils = Utils();

  @override
  void initState() {
    super.initState();
  }

  final _fromForgetPassword = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage;

  @override
  Widget build(BuildContext context) {
    String validationEmail = "email";
    final emailField = Utils.getFormField("Email", validationEmail,
        emailController, const Icon(Icons.email_outlined),
        keyboardType: TextInputType.emailAddress);
    final forgetPasswordButton =
        Utils.getFormButton("Forget Password", onPress: () async {
      if (_fromForgetPassword.currentState.validate()) {
        await userService.forgetPassword(emailController.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });

    double width = 100;
    MediaQueryData mediaQuery;
    if (!kIsWeb) {
      mediaQuery = utils.getWidth(context);
      width = mediaQuery.size.width;
    }
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onVerticalDragDown],
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _fromForgetPassword,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              fontFamily: Config.fontFamily,
                              fontSize: 30.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "Please sign in to continue.",
                          style: TextStyle(
                            fontFamily: Config.fontFamily,
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        emailField,
                        const SizedBox(
                          height: 30,
                        ),
                        forgetPasswordButton,
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        )
                      },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Config.baseColorDart,
                      fontSize: 18,
                    ),
                  )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
