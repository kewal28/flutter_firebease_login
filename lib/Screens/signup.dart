import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_firebease_login/Screens/Privacy.dart';
import 'package:flutter_firebease_login/Screens/after_login_page.dart';
import 'package:flutter_firebease_login/Screens/login.dart';
import 'package:flutter_firebease_login/Services/user.dart';
import 'package:flutter_firebease_login/config.dart';
import 'package:flutter_firebease_login/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserService userService = UserService();
  Utils utils = Utils();
  String errorMessage;

  final _fromSignup = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Future<List<SignUp>> futurePost;
  // var SignUpService = new SignUpService();

  // void initState() {
  //   var futurePost1 = SignUpService.SignUp("kewal", "123456");
  //   print(futurePost1);
  // }
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    String validationName = "required";
    final nameField = Utils.getFormField(
      "Name",
      validationName,
      nameController,
      const Icon(Icons.person_rounded),
      keyboardType: TextInputType.text,
    );

    String validationEmail = "email";
    final emailField = Utils.getFormField(
      "Email",
      validationEmail,
      emailController,
      const Icon(Icons.email_outlined),
      keyboardType: TextInputType.emailAddress,
    );

    String validationPhone = "phone";
    final phoneField = Utils.getFormField(
      "Phone",
      validationPhone,
      mobileController,
      const Icon(Icons.phone_android_outlined),
      keyboardType: TextInputType.number,
    );

    String validationPassword = "password";
    final passwordField = Utils.getFormField(
      "Password",
      validationPassword,
      passwordController,
      const Icon(Icons.password_rounded),
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
      ),
    );

    final signupButton = Material(
      child: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Config.baseColorDart),
          ),
          label: const Text("Sing Up"),
          icon: const Icon(
            Icons.arrow_right,
            color: Colors.white,
          ),
          onPressed: () async {
            if (_fromSignup.currentState.validate()) {
              await userService.singUp(
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                  mobileController.text);
              if (utils.checkUserLogin(context)) {
                Fluttertoast.showToast(msg: Config.signUpMsg);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AfterLoginPage(),
                  ),
                );
              }
            }
          }
          // onPressed: () {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => ProductListPage()));
          // },
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _fromSignup,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: Config.fontFamily,
                            fontSize: 30.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Please sign up to continue.",
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
                        nameField,
                        const SizedBox(
                          height: 20,
                        ),
                        emailField,
                        const SizedBox(
                          height: 20,
                        ),
                        phoneField,
                        const SizedBox(
                          height: 20,
                        ),
                        passwordField,
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text("By clicking logging you agree to the "),
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
                        signupButton,
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                ),
                child: Text(
                  "Login",
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
