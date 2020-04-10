import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/screens/login_screen.dart';
import 'package:flutter/widgets.dart';
import '../../router.dart';
import './bloc.dart';
import '../flashcards/bloc.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deckRepository;
  final FlashcardsBloc flashcardsBloc;

  DeckBloc({@required this.deckRepository, @required this.flashcardsBloc})
      : assert(deckRepository != null),
        assert(flashcardsBloc != null);

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
      flashcardsBloc
          .add(LoadFlashcards(new List(), event.deckId, firstPage, 0));
      navigatorKey.currentState
          .pushNamed(CardViewRoute, arguments: event.deckId);
    } else if (event is DeleteDeck) {
      await deckRepository.delete(event.deckId);
      add(LoadDecks());
    } else if (event is AddDeck) {
      await deckRepository.addDeck(event.name);
      add(LoadDecks());
    } else if (event is LoadDeckFlashcards) {
      var firstPage = 0;
      flashcardsBloc
          .add(LoadFlashcards(new List(), event.deckId, firstPage, 0));
      navigatorKey.currentState
          .pushNamed(CardsViewRoute, arguments: event.deckId);
    }
  }
}
