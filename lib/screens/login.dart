import 'package:flashcards/repositories/auth_repository.dart';
import 'package:flashcards/router.dart';
import 'package:flashcards/utils/auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    Future<void> handleSignIn() async {
      loginWithGoogle();
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
                height: 70,
                width: 200,
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: handleSignIn),
                  ],
                ))));
  }

  login() {}
}
