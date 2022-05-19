import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firebease_login/Screens/Privacy.dart';
import 'package:flutter_firebease_login/Screens/after_login_page.dart';
import 'package:flutter_firebease_login/Screens/forget_password.dart';
import 'package:flutter_firebease_login/Screens/signup.dart';
import 'package:flutter_firebease_login/Services/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:flutter_firebease_login/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserService userService = UserService();
  Utils utils = Utils();

  @override
  void initState() {
    super.initState();
    // emailController.text = "kanojiakr@gmail.com";
    // passwordController.text = "123456";
  }

  final _fromLogin = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    String validationEmail = "email";
    final emailField = Utils.getFormField("Email", validationEmail,
        emailController, const Icon(Icons.email_outlined),
        keyboardType: TextInputType.emailAddress);
    String validationPassword = "password";
    final passwordField = Utils.getFormField("Password", validationPassword,
        passwordController, const Icon(Icons.password_rounded),
        keyboardType: TextInputType.emailAddress,
        obscureText: _isObscure,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ));

    final loginButton = Material(
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Config.baseColorDart),
        ),
        label: const Text("Login"),
        icon: const Icon(
          Icons.arrow_right,
          color: Colors.white,
        ),
        onPressed: () async {
          if (_fromLogin.currentState.validate()) {
            await userService.singIn(
                emailController.text, passwordController.text);
            if (utils.checkUserLogin(context)) {
              Fluttertoast.showToast(msg: Config.loginMsg);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AfterLoginPage(),
                ),
              );
            }
          }
        },
      ),
    );
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
                    key: _fromLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Login",
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
                          height: 20,
                        ),
                        passwordField,
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text("By clicking logging you agree to the "),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Privacy(),
                                    ))
                              },
                              child: Text(
                                "Privacy & Terms",
                                style: TextStyle(
                                  color: Config.baseColorDart,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        loginButton,
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ),
                            )
                          },
                          child: Text(
                            "Forget password?",
                            style: TextStyle(
                              color: Config.baseColorDart,
                              fontSize: 18,
                            ),
                          ),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
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
                      builder: (context) => const SignUp(),
                    ),
                  )
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Config.baseColorDart,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
