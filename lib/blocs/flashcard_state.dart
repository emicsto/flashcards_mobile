import 'package:flashcards/models/deck.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardState {
  const FlashcardState();
}

class InitialFlashcardState extends FlashcardState {}

class FlashcardLoading extends FlashcardState {}

class FlashcardAdded extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final Deck selectedDeck;
  final List<Deck> decks;

  const FlashcardLoaded(this.selectedDeck, [this.decks = const []]);
}
