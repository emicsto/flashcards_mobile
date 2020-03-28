import 'package:flashcards/screens/flashcard_screen.dart';
import 'package:flashcards/screens/home_screen.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flashcards/widgets/add_flashcard_form.dart';
import 'package:flutter/material.dart';

const String HomeViewRoute = '/';
const String LoginViewRoute = 'login';
const String CardViewRoute = 'flashcard';
const String EmptyDeckViewRoute = 'empty-deck';
const String AddFlashcardViewRoute = 'add-flashcard';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen(title: "Home"));
    case CardViewRoute:
      return MaterialPageRoute(builder: (context) => FlashcardScreen(deckId: settings.arguments));
    case EmptyDeckViewRoute:
      return MaterialPageRoute(builder: (context) => FlashcardScreen());
    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen(authenticationRepository:  settings.arguments,));
    case AddFlashcardViewRoute:
      return MaterialPageRoute(builder: (context) => AddFlashcardForm());
    default:
      return MaterialPageRoute(builder: (context) => HomeScreen(title: "Home"));
  }
}
