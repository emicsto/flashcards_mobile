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
  final String deckId;

  const ShowDeckTapped(this.deckId);
}

class LoadDeckFlashcards extends DeckEvent {
  final String deckId;

  const LoadDeckFlashcards(this.deckId);
}

class DeleteDeck extends DeckEvent {
  final String deckId;

  const DeleteDeck(this.deckId);
}
