import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flashcards/flashcard/flashcard_repository.dart';
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
      var flashcards = await flashcardRepository.getFlashcardsByDeckId(deckId: event.deckId, page: event.page);
    }
  }
}
