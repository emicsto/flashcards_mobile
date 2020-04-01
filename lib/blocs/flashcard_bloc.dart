import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;

  FlashcardBloc({@required this.deckRepository, @required this.flashcardRepository})
      : assert(deckRepository != null), assert(flashcardRepository != null);

  @override
  FlashcardState get initialState => InitialFlashcardState();

  @override
  Stream<FlashcardState> mapEventToState(
    FlashcardEvent event,
  ) async* {
    if(event is LoadFlashcard) {
      var decks = await deckRepository.fetchDecks();
      yield FlashcardLoaded(null, decks);
    }

    if(event is SelectDeck) {
      yield FlashcardLoaded(event.deck, event.decks);
    }

    if(event is AddFlashcard) {
      await flashcardRepository.addFlashcard(event.deckId, event.front, event.back);
      yield FlashcardAdded();
    }
  }
}
