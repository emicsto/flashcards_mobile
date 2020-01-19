import 'package:flashcards/models/flashcard_set.dart';
import 'package:flashcards/widgets/sets/set_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetList extends StatefulWidget {
  @override
  SetListState createState() {
    return new SetListState();
  }
}

class SetListState extends State<SetList> {
  @override
  Widget build(BuildContext context) {
    final header = new Container(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: new Text(
        "SETS",
        style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
      itemCount: flashcardSets.length,
      itemBuilder: (context, i) => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          i == 0 ? header : new Container(),
          SetCard(index: i)
        ],
      ),
    );
  }
}
