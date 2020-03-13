import 'package:flashcards/models/deck.dart';
import 'package:meta/meta.dart';


@immutable
abstract class DeckEvent {
  const DeckEvent();
}

class LoadDecks extends DeckEvent {}

class AddDeck extends DeckEvent {
  final Deck deck;

  const AddDeck(this.deck);
}

class ShowDeckTapped extends DeckEvent {
  final String id;

  const ShowDeckTapped(this.id);
}

