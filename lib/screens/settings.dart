import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flutter/material.dart';

import 'login.dart';

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

  Future<List<Widget>> getDecksAsDialogOptions() async {
    List<Deck> decks = await fetchDecks();
    List<Widget> widgets = [];

    decks.forEach((deck) => {
          widgets.add(SimpleDialogOption(
            child: Text(
              deck.name,
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () =>
                {importFile(deck.id), navigatorKey.currentState.pop()},
          ))
        });

    return widgets;
  }

  Future<void> importFile(int deckId) async {
    try {
      File file = await FilePicker.getFile();
      var flashcardsCsv = await file.readAsString();
      await importFlashcards(deckId, flashcardsCsv);

      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Flashcards were successfully imported")));
    } on Exception {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred while reading the file")));
    }
  }

  void showDecksDialog() async {
    getDecksAsDialogOptions().then((decks) => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  title: Text(
                    'Choose a deck',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  children: decks);
            },
          )
        });
  }

  void showHelpDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            title: Text('Importing flashcards',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Only CSV files can be imported.'),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Elements should be separated by commas.'),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Valid headers are "front" and "back".'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ListTile(
          trailing: IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () => showHelpDialog()),
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 0),
          title: Text(
            'Data',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 14),
          )),
      ListTile(
        title: Text('Import flashcards'),
        onTap: () => showDecksDialog(),
      )
    ]);
  }
}
