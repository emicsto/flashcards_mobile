import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flashcards/flashcard/blocs/counter/bloc.dart';
import 'package:flashcards/flashcard/flashcard_repository.dart';
import 'package:flutter/widgets.dart';

import 'bloc.dart';

class FlashcardsBloc extends Bloc<FlashcardsEvent, FlashcardsState> {
  final FlashcardRepository flashcardRepository;
  final CounterBloc counterBloc;

  FlashcardsBloc({@required this.flashcardRepository, @required this.counterBloc})
      : assert(flashcardRepository != null), assert(counterBloc != null);

  @override
  FlashcardsState get initialState => FlashcardsNotLoaded();

  @override
  Stream<FlashcardsState> mapEventToState(
    FlashcardsEvent event,
  ) async* {
    if (event is LoadFlashcards) {
      var flashcards = await flashcardRepository.getFlashcardsByDeckId(
          deckId: event.deckId, page: event.page);
//      if(event.page == 0) {
//        counterBloc.add(CounterEvent.reset);
//      }

      if (flashcards.isEmpty) {
        yield NoFlashcards();
      } else {
        yield FlashcardsLoaded(flashcards);
      }
    }
  }
}
