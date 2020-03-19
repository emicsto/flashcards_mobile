import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/screens/settings_screen.dart';
import 'package:flashcards/widgets/add_deck_form.dart';
import 'package:flashcards/widgets/decks.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final DeckRepository deckRepository;
  final String title;

  HomeScreen({Key key, this.title, @required this.authenticationRepository, @required this.deckRepository}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addDeckModal(context) {
    showModalBottomSheet(context: context, builder: (_) => AddDeckForm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Flashcards"),
        ),
      ),
      body: <Widget>[Decks(deckRepository:  widget.deckRepository), SettingsScreen(authenticationRepository:  widget.authenticationRepository,)].elementAt(_selectedIndex),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                addDeckModal(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        elevation: 0,
        selectedItemColor: Colors.teal,
        iconSize: 25,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
