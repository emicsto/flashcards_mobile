import 'package:flashcards/widgets/decks/decks.dart';
import 'package:flutter/material.dart';

import 'models/deck.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
