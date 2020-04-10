import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/screens/flashcards_screen.dart';
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
    _onDeckTapped(String id) {
      BlocProvider.of<DeckBloc>(context).add(
        ShowDeckTapped(id),
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

    _onShowFlashcardsTapped(String id) {
      Navigator.of(context).pop();
      BlocProvider.of<DeckBloc>(context).add(
          LoadDeckFlashcards(id);
      );
    }

    void onDeckLongPress(context, String id) {
      showModalBottomSheet(
          context: context,
          builder: (_) => ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  title: Text('Delete deck'),
                  onTap: () {
                    BlocProvider.of<DeckBloc>(context).add(
                      DeleteDeck(id),
                    );
                    Navigator.of(context).pop();
                    _showDeckDeletedSnackBar();
                  }),
              ListTile(
                  leading: Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  title: Text('Rename deck'),
                  onTap: () {
                   // TODO: implement
                  }),
              ListTile(
                  leading: Icon(
                    Icons.filter_none,
                    size: 20,
                  ),
                  title: Text('Flashcards'),
                  onTap: () => _onShowFlashcardsTapped(id)),
            ],
          ),
      );
    }


    var deck = decks[index];
    return BlocListener<DeckBloc, DeckState>(
        listener: (context, state) {
          if(state is DeckDeleted) {
          }
        },
        child: Container(
            height: 125,
            padding: const EdgeInsets.only(bottom: 5),

              child: Card(
                elevation: 2,
                child:           InkWell(
                  onTap: () => _onDeckTapped(deck.id),
                  onLongPress: () => onDeckLongPress(context, deck.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Text(
                              deck.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Container(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            deck.quantity.toString() + " terms",
                            style:
                            TextStyle(color: Colors.grey, fontSize: 13.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
