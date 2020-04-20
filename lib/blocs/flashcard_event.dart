import 'package:flashcards/models/deck.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardEvent {
  const FlashcardEvent();
}

class LoadFlashcard extends FlashcardEvent {
  final String selectedDeckId;

  const LoadFlashcard(this.selectedDeckId);
}

class SelectDeck extends FlashcardEvent {
  final Deck deck;
  final List<Deck> decks;

  const SelectDeck(this.deck, this.decks);
}

class AddFlashcard extends FlashcardEvent {
  final String deckId;
  final String front;
  final String back;

  const AddFlashcard(this.deckId, this.front, this.back);
}


