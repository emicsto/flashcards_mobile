import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flutter/widgets.dart';

import 'bloc.dart';

class FlashcardsBloc extends Bloc<FlashcardsEvent, FlashcardsState> {
  final FlashcardRepository flashcardRepository;

  FlashcardsBloc({@required this.flashcardRepository})
      : assert(flashcardRepository != null);

  @override
  FlashcardsState get initialState => FlashcardsNotLoaded();

  @override
  Stream<FlashcardsState> mapEventToState(
    FlashcardsEvent event,
  ) async* {
    if (event is LoadFlashcards) {
      if(event.flashcards.length == 0) {
        yield FlashcardsNotLoaded();
      }

      var flashcards = event.flashcards;
      flashcards.addAll(await flashcardRepository.getFlashcardsByDeckId(
          deckId: event.deck.id, page: event.page));

      if (flashcards.isEmpty) {
        yield NoFlashcards();
      } else {
        yield FlashcardsLoaded(flashcards, event.page, event.index, true);
      }
    } else if (event is IncrementIndex) {
      if (event.flashcards.isEmpty) {
        yield NoFlashcards();
      } else {
        yield FlashcardsLoaded(
            event.flashcards, event.page, event.index + 1, false);
      }
    } else if (event is ImportFlashcards) {
      await flashcardRepository.saveFlashcards(event.deckId, event.flashcardsCsv);
      yield FlashcardsImported();
    }
  }
}


