import 'package:flashcards/models/deck.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeckState {
  const DeckState();
}

class DeckInitial extends DeckState {}

class DeckLoading extends DeckState {}

class DecksLoaded extends DeckState {
  final List<Deck> decks;

  const DecksLoaded([this.decks = const []]);
}

class DeckNotLoaded extends DeckState {}

