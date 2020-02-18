import 'package:flashcards/screens/card_screen.dart';
import 'package:flashcards/screens/home.dart';
import 'package:flashcards/screens/login.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String LoginViewRoute = 'login';
const String CardViewRoute = 'flashcard';
const String EmptyDeckViewRoute = 'empty-deck';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage(title: "Home"));
    case CardViewRoute:
      return MaterialPageRoute(builder: (context) => CardScreen(deckId: settings.arguments));
    case EmptyDeckViewRoute:
      return MaterialPageRoute(builder: (context) => CardScreen());
    default:
      return MaterialPageRoute(builder: (context) => Login(title: "Login"));
  }
}
