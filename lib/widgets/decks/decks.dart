import 'package:flashcards/models/deck.dart';
import 'package:flashcards/widgets/decks/deck_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Decks extends StatefulWidget {
  @override
  DecksState createState() {
    return new DecksState();
  }
}

class DecksState extends State<Decks> {
  @override
  Widget build(BuildContext context) {
    final header = new Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: new Text(
        "DECKS",
        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
      itemCount: decks.length,
      itemBuilder: (context, i) => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          i == 0 ? header : new Container(),
          DeckCard(index: i)
        ],
      ),
    );
  }
}
