import 'package:meta/meta.dart';

@immutable
abstract class FlashcardEvent {
  const FlashcardEvent();
}

class LoadFlashcard extends FlashcardEvent {
  const LoadFlashcard();
}

class AddFlashcard extends FlashcardEvent {
  final String deckId;
  final String front;
  final String back;

  const AddFlashcard(this.deckId, this.front, this.back);
}


