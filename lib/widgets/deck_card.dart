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
    _onDeckTapped(String id) {
      BlocProvider.of<DeckBloc>(context).add(
        ShowDeckTapped(id),
      );
    }

    showDeckDeletedSnackBar() {
      Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 2500),
          content: Text("Deck successfully deleted"),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            })));
    }

    void onDeckLongPress(context, String id) {
      showModalBottomSheet(
          context: context,
          builder: (_) => ListTile(
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
                showDeckDeletedSnackBar();
              }));
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
