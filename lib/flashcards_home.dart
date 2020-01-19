import 'package:flashcards/widgets/sets/set_list.dart';
import 'package:flutter/material.dart';

import 'models/flashcard_set.dart';

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
      body: SetList(),
    );
  }
}
