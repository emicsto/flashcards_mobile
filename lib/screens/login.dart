import 'package:flashcards/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: ['email'],
);

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      await loginWithGoogle();

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }

    var loginText = Text(
      "Login",
      style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.4),
    );

    var loginButton = Container(
      height: 50,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleSignInButton(onPressed: handleSignIn),
    );

    var loginImage = SizedBox.fromSize(
      child: SvgPicture.asset(
        'images/login.svg',
      ),
      size: Size(280.0, 280.0),
    );

    return Scaffold(
        backgroundColor: Color(0xFF268979),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              loginText,
              loginImage,
              loginButton,
            ])));
  }
}
