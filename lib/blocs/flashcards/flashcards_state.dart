import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/widgets/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FlashcardsState {
  const FlashcardsState();
}

class FlashcardsInitial extends FlashcardsState {}

class FlashcardsLoading extends FlashcardsState {}

class FlashcardsLoaded extends FlashcardsState {
  final List<CardModel> flashcards;
  final int page;
  final int index;
  final bool newCards;

  const FlashcardsLoaded([this.flashcards = const [], this.page = 0, this.index = 0, this.newCards]);
}

class NoFlashcards extends FlashcardsState {}

class FlashcardsNotLoaded extends FlashcardsState {}
