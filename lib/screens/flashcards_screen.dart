import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flashcards/router.dart';
import 'package:flashcards/screens/empty_deck_screen.dart';
import 'package:flashcards/widgets/loader_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/flashcards/bloc.dart';

class FlashcardsScreen extends StatelessWidget {
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;
  final Deck deck;

  FlashcardsScreen({Key key, this.deck, this.deckRepository, this.flashcardRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(deck.name)),
        body: BlocListener<FlashcardsBloc, FlashcardsState>(
          listener: (context, state) {},
          child: BlocBuilder<FlashcardsBloc, FlashcardsState>(
            builder: (context, state) {
              if (state is NoFlashcards) {
                return EmptyDeckScreen();
              } else if (state is FlashcardsLoaded) {
                return ListView.separated(
                   separatorBuilder:  (context, index) => Divider(
                   ),
                  itemCount: state.flashcards.length,
                    itemBuilder: (context, index) =>
                        _makeRow(state.flashcards[index].front, context));
              } else {
                return LoaderCentered();
              }
            },
          ),
        ));
  }

  _makeRow(String front, BuildContext context) {
    return ListTile(
      title: Text(front),
      onTap: () => _addFlashcard(context),
    );
  }

  void _addFlashcard(context) {
    Navigator.pushNamed(context, AddFlashcardViewRoute, arguments: ScreenArguments(deckRepository, flashcardRepository));
  }
}
