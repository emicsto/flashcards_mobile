import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/router.dart';
import 'package:flashcards/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
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
    }

    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text("Login"),
          ),
        ),
        body: Center(
            child: Container(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//                    GoogleSignInButton(onPressed: () {}),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : GoogleSignInButton(onPressed: handleSignIn, darkMode: true),
          ],
        ))));
  }
}

