import 'package:flashcards/blocs/bloc.dart';
import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFlashcardScreen extends StatefulWidget {
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;

  const CreateFlashcardScreen({Key key, @required this.deckRepository, @required this.flashcardRepository})
      : super(key: key);

  @override
  CreateFlashcardScreenState createState() => CreateFlashcardScreenState();
}

class CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();

  void _handleSaveDeck(
      String deckId, String front, String back, BuildContext context) {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<FlashcardBloc>(context)
          .add(AddFlashcard(deckId, front, back));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlashcardBloc>(
        create: (context) => FlashcardBloc(
          deckBloc: BlocProvider.of<DeckBloc>(context),
              deckRepository: widget.deckRepository,
              flashcardRepository: widget.flashcardRepository,
            )..add(LoadFlashcard()),
        child: BlocListener<FlashcardBloc, FlashcardState>(
            listener: (context, state) {},
            child: BlocBuilder<FlashcardBloc, FlashcardState>(
              builder: (context, state) {
                return Scaffold(
                    backgroundColor: Color(0xFF1F2025),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Color(0xFF9BA0A6)),
                      backgroundColor: Color(0xFF1F2025),
                      elevation: 0,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endDocked,
                    floatingActionButton: FloatingActionButton(
                        child: const Icon(
                          Icons.send,
                        ),
                        onPressed: () => state is FlashcardLoaded
                            ? _handleSaveDeck(
                                state.selectedDeck?.id,
                                _frontController.text,
                                _backController.text,
                                context)
                            : {}),
                    bottomNavigationBar: BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.format_bold),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.format_align_center),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.format_align_justify),
                              color: Colors.white,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    body: ListView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(22),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  state is FlashcardLoaded
                                      ? DropdownButtonFormField<Deck>(
                                          onChanged: (Deck deck) {
                                            BlocProvider.of<FlashcardBloc>(
                                                    context)
                                                .add(SelectDeck(
                                                    deck, state.decks));
                                          },
                                    validator: (value) => value == null ? 'Deck is required' : null,
                                    hint: Text("Deck"),
                                          isExpanded: true,
                                          value: state.selectedDeck,
                                          items: state.decks.map((Deck deck) {
                                            return DropdownMenuItem<Deck>(
                                              value: deck,
                                              child: Text(deck.name),
                                            );
                                          }).toList(),
                                        )
                                      : Container(),
                                  TextFormField(
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
                                      FocusScope.of(context)
                                          .requestFocus(focus);
                                    },
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Front of the flashcard can not be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
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
                                  ),
                                ],
                              )),
                        )
                      ],
                    ));
              },
            )));
  }
}
