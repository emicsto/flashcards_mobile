import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardsState {
  const FlashcardsState();
}

class FlashcardsInitial extends FlashcardsState {}

class FlashcardsLoading extends FlashcardsState {}

class FlashcardsLoaded extends FlashcardsState {
  final List<CardModel> flashcards;

  const FlashcardsLoaded([this.flashcards = const []]);
}

class NoFlashcards extends FlashcardsState {}

class FlashcardsNotLoaded extends FlashcardsState {}
