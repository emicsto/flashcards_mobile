import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckCard extends StatelessWidget {
  final int index;
  final List<Deck> decks;

  const DeckCard({
    Key key,
    this.index,
    this.decks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onDeckTapped(Deck deck) {
      BlocProvider.of<DeckBloc>(context).add(
        ShowDeckTapped(deck),
      );
    }

    _showDeckDeletedSnackBar() {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 2500),
          content: Text("Deck successfully deleted"),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                //TODO: Some code to undo the change.
              })));
    }

    _onShowFlashcardsTapped(Deck deck) {
      BlocProvider.of<DeckBloc>(context).add(LoadDeckFlashcards(deck));
    }

    void showDeckOptionsSheet(context, Deck deck) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          var deleteDeckTile = ListTile(
              leading: Icon(
                Icons.delete,
                size: 20,
              ),
              title: Text('Delete deck'),
              onTap: () {
                BlocProvider.of<DeckBloc>(context).add(
                  DeleteDeck(deck.id),
                );
                Navigator.of(context).pop();
                _showDeckDeletedSnackBar();
              });

          var editDeckTile = ListTile(
              leading: Icon(
                Icons.edit,
                size: 20,
              ),
              title: Text('Rename deck'),
              onTap: () {
                // TODO: implement
              });

          var showFlashcards = ListTile(
              leading: Icon(
                Icons.filter_none,
                size: 20,
              ),
              title: Text('Flashcards'),
              onTap: () => _onShowFlashcardsTapped(deck));

          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              deleteDeckTile,
              editDeckTile,
              showFlashcards,
            ],
          );
        },
      );
    }

    var deck = decks[index];
    var deckCard = Card(
      elevation: 2,
      child: InkWell(
        onTap: () => _onDeckTapped(deck),
        onLongPress: () => showDeckOptionsSheet(context, deck),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    deck.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    deck.quantity.toString() + " terms",
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showDeckOptionsSheet(context, deck),
                )
              ],
            )
          ],
        ),
      ),
    );

    return BlocListener<DeckBloc, DeckState>(
        listener: (context, state) {
          if (state is DeckDeleted) {}
        },
        child: Container(
          height: 125,
          padding: const EdgeInsets.only(bottom: 5),
          child: deckCard,
        ));
  }
}
