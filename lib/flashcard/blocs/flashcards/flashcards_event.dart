import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardsEvent {
  const FlashcardsEvent();
}

class LoadFlashcards extends FlashcardsEvent {
  final String deckId;
  final int page;

  const LoadFlashcards(this.deckId, this.page);
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
