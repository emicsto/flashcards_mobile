import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flashcards/blocs/authentication/bloc.dart';
import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/blocs/flashcards/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';
import '../router.dart';

class SettingsScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  SettingsScreen({Key key, @required this.authenticationRepository})
      : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Widget>> getDecksAsDialogOptions(List<Deck> decks) async {
    List<Widget> widgets = [];

    decks.forEach((deck) => {
          widgets.add(SimpleDialogOption(
            child: Text(
              deck.name,
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () => {
              onImportFlashcardsPressed(deck.id),
              navigatorKey.currentState.pop()
            },
          ))
        });

    return widgets;
  }

  Future<void> onImportFlashcardsPressed(String deckId) async {
    try {
      File file = await FilePicker.getFile();
      var flashcardsCsv = await file.readAsString();
      BlocProvider.of<FlashcardsBloc>(context)
          .add(ImportFlashcards(deckId, flashcardsCsv));

      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Flashcards were successfully imported")));
    } on Exception {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("An error occurred while reading the file")));
    }
  }

  void showDecksDialog(List<Deck> decks) async {
    BlocProvider.of<DeckBloc>(context).add(LoadDecks());

    getDecksAsDialogOptions(decks).then((deckWidgets) => {
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
                  children: deckWidgets);
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
    return BlocListener<FlashcardsBloc, FlashcardsState>(
      listener: (context, state) {
        if (state is FlashcardsImported) {
          BlocProvider.of<DeckBloc>(context).add(LoadDecks());
        }
      },
      child: BlocBuilder<DeckBloc, DeckState>(
        builder: (context, state) {
          return ListView(children: <Widget>[
            ListTile(
                trailing: IconButton(
                    icon: Icon(
                      Icons.help_outline,
                      size: 20,
                    ),
                    onPressed: () => showHelpDialog()),
                title: Text(
                  'Data',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 15),
                )),
            ListTile(
                title: Text('Import flashcards',                  style: TextStyle(
                    fontSize: 16)),
                onTap: () {
                  if (state is DecksLoaded) {
                    if (state.decks.isEmpty) {
                      return showNoDecksSnackBar();
                    } else {
                      return showDecksDialog(state.decks);
                    }
                  }
                }),
            Divider(),
            ListTile(
                title: Text(
                  'General',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 15),
                )),
            ListTile(
                title: Text('Sign out',                  style: TextStyle(
                    fontSize: 16)),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                }),
          ]);
        },
      ),
    );
  }

  showNoDecksSnackBar() {
    Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 2500),
        content: Text(
            "You don't have any deck to which you could add imported flashcards")));
  }
}
