import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  @override
  FlashcardState get initialState => FlashcardFront();

  @override
  Stream<FlashcardState> mapEventToState(
    FlashcardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
