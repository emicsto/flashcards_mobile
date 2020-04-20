import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';
import 'deck/bloc.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  final DeckBloc deckBloc;
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;

  FlashcardBloc({@required this.deckBloc, @required this.deckRepository, @required this.flashcardRepository})
      : assert(deckBloc != null), assert(deckRepository != null), assert(flashcardRepository != null);

  @override
  FlashcardState get initialState => InitialFlashcardState();

  @override
  Stream<FlashcardState> mapEventToState(
    FlashcardEvent event,
  ) async* {
    if(event is LoadFlashcard) {
      var decks = await deckRepository.fetchDecks();
      if(event.selectedDeckId == null) {
        yield FlashcardLoaded(null, decks);
      } else {
        var deck = decks.firstWhere((deck) => deck.id == event.selectedDeckId);
        yield FlashcardLoaded(deck, decks);
      }
    }

    if(event is SelectDeck) {
      yield FlashcardLoaded(event.deck, event.decks);
    }

    if(event is AddFlashcard) {
      await flashcardRepository.addFlashcard(event.deckId, event.front, event.back);
      deckBloc.add(LoadDecks());
      navigatorKey.currentState.pop();
    }
  }
}
