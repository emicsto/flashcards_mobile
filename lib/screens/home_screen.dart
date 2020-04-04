import 'package:flashcards/repositories/authentication_repository.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flashcards/screens/settings_screen.dart';
import 'package:flashcards/widgets/add_deck_form.dart';
import 'package:flashcards/widgets/decks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../router.dart';

class HomeScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;
  final String title;

  HomeScreen(
      {Key key,
      this.title,
      @required this.authenticationRepository,
      @required this.flashcardRepository,
      @required this.deckRepository})
      : super(key: key);

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

  void addFlashcard(context) {
    Navigator.pushNamed(context, AddFlashcardViewRoute, arguments: ScreenArguments(widget.deckRepository, widget.flashcardRepository));
  }

  @override
  Widget build(BuildContext context) {
    var isBrightnessDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark ? true : false;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Flashcards"),
        ),
      ),
      body: <Widget>[
        Decks(deckRepository: widget.deckRepository),
        SettingsScreen(
          authenticationRepository: widget.authenticationRepository,
        )
      ].elementAt(_selectedIndex),
      floatingActionButton: _selectedIndex == 0
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              animationSpeed: 50,
              closeManually: false,
              curve: Curves.easeInOutExpo,
              overlayColor: Colors.black,
              overlayOpacity: 0.3,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: isBrightnessDark ? Color(0xFF005082) : Colors.teal,
                  label: "Add deck",
                  labelStyle: TextStyle(color: Colors.black),
                  onTap: () => addDeckModal(context),
                ),
                SpeedDialChild(
                  child: Icon(Icons.library_add),
                  backgroundColor: isBrightnessDark ? Color(0xFF005082) : Colors.teal,
                  label: "Add flashcard",
                  labelStyle: TextStyle(color: Colors.black),
                  onTap: () => addFlashcard(context),
                ),
              ],
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 14,
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
