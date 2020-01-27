import 'package:flashcards/screens/flashcards_home.dart';
import 'package:flashcards/screens/login.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String LoginViewRoute = 'login';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
     return MaterialPageRoute(builder: (context) => HomePage(title: "Home"));
    default:
      return MaterialPageRoute(builder: (context) => Login(title: "Login"));
  }
}