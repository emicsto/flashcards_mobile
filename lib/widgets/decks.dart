import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/widgets/deck_card.dart';
import 'package:flashcards/widgets/loader_centered.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Decks extends StatefulWidget {
  final decksStateKey = GlobalKey<DecksState>();
  final DeckRepository deckRepository;

  Decks({Key key, @required this.deckRepository})
      : assert(deckRepository != null),
        super(key: key);

  @override
  DecksState createState() {
    return new DecksState();
  }
}

class DecksState extends State<Decks> {
  List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    final header = new Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: new Text(
        "DECKS",
        style: new TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );

    return BlocListener<DeckBloc, DeckState>(
        listener: (context, state) {},
        child: BlocBuilder<DeckBloc, DeckState>(
          builder: (context, state) {
            if (state is DecksLoaded) {
              var decks = state.decks;

              return ListView.builder(
                padding:
                    EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
                itemCount: decks.length,
                itemBuilder: (context, i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    i == 0 ? header : Container(),
                    DeckCard(index: i, decks: decks)
                  ],
                ),
              );
            } else if (state is DeckLoading) {
              return LoaderCentered();
            }
            return LoaderCentered();
          },
        ));
  }
}
