import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/deck/deck_repository.dart';
import 'package:flashcards/flashcard/blocs/flashcards/bloc.dart';
import 'package:flashcards/login/login_page.dart';
import 'package:flutter/widgets.dart';
import '../../router.dart';
import './bloc.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deckRepository;
  final FlashcardsBloc flashcardsBloc;

  DeckBloc({@required this.deckRepository, @required this.flashcardsBloc})
      : assert(deckRepository != null), assert(flashcardsBloc != null);

  @override
  DeckState get initialState => DeckInitial();

  @override
  Stream<DeckState> mapEventToState(
    DeckEvent event,
  ) async* {
    if (event is LoadDecks) {
      yield DeckLoading();
      var decks = await deckRepository.fetchDecks();

      yield DecksLoaded(decks);
    } else if (event is ShowDeckTapped) {
      var firstPage = 0;
      flashcardsBloc.add(LoadFlashcards(new List(), event.deckId, firstPage, 0));
      navigatorKey.currentState.pushNamed(CardViewRoute, arguments: event.deckId);
    } else if (event is AddDeck) {
      await deckRepository.addDeck(event.name);
      add(LoadDecks());
    }
  }
}
