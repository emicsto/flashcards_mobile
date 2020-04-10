import 'package:flashcards/models/deck.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DeckEvent {
  const DeckEvent();
}

class LoadDecks extends DeckEvent {}

class AddDeck extends DeckEvent {
  final String name;

  const AddDeck(this.name);
}

class ShowDeckTapped extends DeckEvent {
  final Deck deck;

  const ShowDeckTapped(this.deck);
}

class LoadDeckFlashcards extends DeckEvent {
  final Deck deck;

  const LoadDeckFlashcards(this.deck);
}

class DeleteDeck extends DeckEvent {
  final String deckId;

  const DeleteDeck(this.deckId);
}
