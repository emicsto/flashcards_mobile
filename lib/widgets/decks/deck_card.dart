import 'package:flashcards/models/deck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/screens/login.dart';
import 'package:flashcards/router.dart';

class DeckCard extends StatelessWidget {
  final int index;
  final List<Deck> decks;

  const DeckCard({
    Key key,
    this.index, this.decks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState.pushNamed(CardViewRoute, arguments: index),
      child: new Container(
          height: 125,
          padding: const EdgeInsets.only(bottom: 5),
          child: new Card(
            elevation: 2,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                new ListTile(
                  title: new Row(
                    children: <Widget>[
                      new Text(
                        decks[index].name,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: new Container(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      decks[index].quantity.toString() + " terms",
                      style: new TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  ),
                )
              ],
            ),
          ))
    );
  }
}
