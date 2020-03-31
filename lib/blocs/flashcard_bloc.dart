import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flutter/widgets.dart';
import './bloc.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  final DeckRepository deckRepository;

  FlashcardBloc({@required this.deckRepository})
      : assert(deckRepository != null);

  @override
  FlashcardState get initialState => InitialFlashcardState();

  @override
  Stream<FlashcardState> mapEventToState(
    FlashcardEvent event,
  ) async* {
    if(event is LoadFlashcard) {
      var decks = await deckRepository.fetchDecks();
      yield FlashcardLoaded(decks);
    }
  }
}
