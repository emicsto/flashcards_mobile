import 'package:flashcards/blocs/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFlashcardForm extends StatelessWidget {
  const CreateFlashcardForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController frontController,
    @required this.focus,
    @required TextEditingController backController,
    @required FlashcardLoaded state,
  }) : _formKey = formKey, _frontController = frontController, _backController = backController, state = state, super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _frontController;
  final FocusNode focus;
  final TextEditingController _backController;
  final FlashcardLoaded state;

  @override
  Widget build(BuildContext context) {
    var decksDropdown = DropdownButtonFormField<Deck>(
              onChanged: (Deck deck) {
                BlocProvider.of<FlashcardBloc>(context)
                    .add(SelectDeck(deck, state.decks));
              },
              validator: (value) =>
              value == null ? 'Deck is required' : null,
              hint: Text("Deck"),
              isExpanded: true,
              value: state.selectedDeck,
              items: state.decks.map((Deck deck) {
                return DropdownMenuItem<Deck>(
                  value: deck,
                  child: Text(deck.name),
                );
              }).toList(),
            );

    var frontTextField = TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: _frontController,
              autofocus: true,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                hintText: "Front",
                hintStyle: TextStyle(fontSize: 22),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(focus);
              },
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Front of the flashcard can not be empty';
                }
                return null;
              },
            );

    var backTextField = TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              focusNode: focus,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: "Back",
                hintStyle: TextStyle(fontSize: 16),
                border: InputBorder.none,
              ),
              controller: _backController,
              validator: (value) {
                if (value.trim().isEmpty) {
                  return 'Back of the flashcard can not be empty';
                }
                return null;
              },
            );

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            decksDropdown,
            frontTextField,
            backTextField,
          ],
        ));
  }
}
