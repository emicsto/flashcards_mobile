
import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDeckForm extends StatefulWidget {
  const AddDeckForm({Key key}) : super(key: key);

  @override
  AddDeckFormState createState() => AddDeckFormState();
}

class AddDeckFormState extends State<AddDeckForm> {
  final deckController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleSaveDeck(BuildContext context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<DeckBloc>(context).add(AddDeck(deckController.text));

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    deckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: deckController,
                    decoration: InputDecoration(hintText: 'Enter a deck name'),
                    autofocus: true,
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Deck name can not be empty';
                      }
                      return null;
                    },
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () => _handleSaveDeck(context),
                      child: Text("Add deck"),
                    ),
                  )
                ],
              ))),
    );
  }
}