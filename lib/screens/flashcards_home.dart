import 'package:flashcards/widgets/decks/decks.dart';
import 'package:flutter/material.dart';

import '../models/deck.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
            child: Text(widget.title),
        ),
      ),
      body: Decks(),
    );
  }
}
