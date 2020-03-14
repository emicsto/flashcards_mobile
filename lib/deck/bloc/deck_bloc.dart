import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/deck/deck_repository.dart';
import 'package:flashcards/login/login_page.dart';
import 'package:flutter/widgets.dart';
import '../../router.dart';
import './bloc.dart';

class DeckBloc extends Bloc<DeckEvent, DeckState> {
  final DeckRepository deckRepository;

  DeckBloc({@required this.deckRepository})
      : assert(deckRepository != null);

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
      navigatorKey.currentState
          .pushNamed(CardViewRoute, arguments: event.id);
//      yield ShowDeck(event.id);
    }
  }
}
