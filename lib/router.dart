import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flashcards/screens/flashcard_screen.dart';
import 'package:flashcards/screens/home_screen.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flashcards/screens/create_flashcard_screen.dart';
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
      ScreenArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => CreateFlashcardScreen(deckRepository: args.deckRepository, flashcardRepository: args.flashcardRepository, ));
    default:
      return MaterialPageRoute(builder: (context) => HomeScreen(title: "Home"));
  }
}


class ScreenArguments {
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;

  ScreenArguments(this.deckRepository, this.flashcardRepository);
}
