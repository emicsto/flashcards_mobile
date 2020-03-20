import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/widgets/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardsEvent {
  const FlashcardsEvent();
}

class LoadFlashcards extends FlashcardsEvent {
  final List<CardModel> flashcards;
  final String deckId;
  final int page;
  final int index;

  const LoadFlashcards(this.flashcards, this.deckId, this.page, this.index);
}

class IncrementIndex extends FlashcardsEvent {
  final List<CardModel> flashcards;
  final String deckId;
  final int page;
  final int index;

  const IncrementIndex(this.flashcards, this.deckId, this.page, this.index);
}

class AddFlashcard extends FlashcardsEvent {
  final Flashcard flashcard;

  const AddFlashcard(this.flashcard);
}

class ImportFlashcards extends FlashcardsEvent {
  final String deckId;
  final String flashcardsCsv;

  const ImportFlashcards(this.deckId, this.flashcardsCsv);
}
