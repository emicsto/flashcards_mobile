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
    this.index,
    this.decks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deck = decks[index];
    return GestureDetector(
        onTap: () => navigatorKey.currentState
            .pushNamed(CardViewRoute, arguments: index),
        child:  Container(
            height: 125,
            padding: const EdgeInsets.only(bottom: 5),
            child:  Card(
              elevation: 2,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   ListTile(
                    title:  Row(
                      children: <Widget>[
                         Text(
                          deck.name,
                          style:  TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle:  Container(
                      padding: const EdgeInsets.only(top: 15.0),
                      child:  Text(
                        deck.quantity.toString() + " terms",
                        style:
                             TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
