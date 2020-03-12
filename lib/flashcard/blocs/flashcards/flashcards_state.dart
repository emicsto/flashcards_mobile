import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardsState {
  const FlashcardsState();
}

class FlashcardsInitial extends FlashcardsState {}

class FlashcardsLoading extends FlashcardsState {}

class FlashcardsLoaded extends FlashcardsState {
  final List<Flashcard> flashcards;

  const FlashcardsLoaded([this.flashcards = const []]);
}

class FlashcardsNotLoaded extends FlashcardsState {}
