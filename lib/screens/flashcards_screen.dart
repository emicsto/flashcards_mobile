import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/empty_deck_screen.dart';
import 'package:flashcards/widgets/loader_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/flashcards/bloc.dart';


class FlashcardsScreen extends StatelessWidget {
  final Deck deck;

  FlashcardsScreen({Key key, this.deck}) : super(key: key);

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
            return Text(state.flashcards.length.toString());
          } else {
            return LoaderCentered();
          }
        },
      ),
    ));
  }
}
