import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flashcards/utils/assessment.dart';
import 'package:flashcards/utils/extended_flip_card_state.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:flashcards/screens/empty_deck.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
          title: Text(
        'Data',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
            fontSize: 14),
      )),
      ListTile(title: Text('Import flashcards'), onTap: () => {})
    ]);
  }
}
