import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/screens/settings.dart';
import 'package:flashcards/widgets/decks/decks.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[Decks(), Settings()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void addDeckModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddDeckForm();
        });
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
      body: _widgetOptions.elementAt(_selectedIndex),
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

class AddDeckForm extends StatefulWidget {
  const AddDeckForm({Key key}) : super(key: key);

  @override
  AddDeckFormState createState() => AddDeckFormState();
}

class AddDeckFormState extends State<AddDeckForm> {
  final deckController = TextEditingController();

  void _handleSaveDeck(BuildContext context) {
    saveDeck(deckController.text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    deckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: deckController,
                  decoration: InputDecoration(hintText: 'Enter a deck name'),
                  autofocus: true,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () => _handleSaveDeck(context),
                    child: Text("Add deck"),
                  ),
                )
              ],
            )));
  }
}
