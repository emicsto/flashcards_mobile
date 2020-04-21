import 'package:flashcards/blocs/bloc.dart';
import 'package:flashcards/blocs/deck/bloc.dart';
import 'package:flashcards/blocs/flashcards/bloc.dart';
import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/repositories/deck_repository.dart';
import 'package:flashcards/repositories/flashcard_repository.dart';
import 'package:flashcards/widgets/loader_centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFlashcardScreen extends StatefulWidget {
  final DeckRepository deckRepository;
  final FlashcardRepository flashcardRepository;
  final FlashcardBloc flashcardBloc;
  final CardModel flashcard;

  const CreateFlashcardScreen(
      {Key key,
      @required this.deckRepository,
      @required this.flashcardRepository,
      @required this.flashcardBloc,
      this.flashcard})
      : super(key: key);

  @override
  CreateFlashcardScreenState createState() => CreateFlashcardScreenState();
}

class CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _frontController.text = widget.flashcard?.front?? null;
    _backController.text = widget.flashcard?.back?? null;
  }

  void _handleSaveDeck(
      String flashcardId, Deck deck, String front, String back, BuildContext context) {
    if (_formKey.currentState.validate()) {
      if(flashcardId == null) {
        BlocProvider.of<FlashcardBloc>(context).add(AddFlashcard(deck.id, front, back));
      } else {
        BlocProvider.of<FlashcardBloc>(context).add(UpdateFlashcard(flashcardId, deck, front, back));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlashcardBloc>(
        create: (context) => FlashcardBloc(
              deckBloc: BlocProvider.of<DeckBloc>(context),
              deckRepository: widget.deckRepository,
              flashcardRepository: widget.flashcardRepository,
              flashcardsBloc: BlocProvider.of<FlashcardsBloc>(context),
        )..add(LoadFlashcard(widget.flashcard?.deckId?? null)),
        child: BlocListener<FlashcardBloc, FlashcardState>(
            listener: (context, state) {},
            child: BlocBuilder<FlashcardBloc, FlashcardState>(
              builder: (context, state) {
                var createFlashcardForm = state is FlashcardLoaded
                    ? Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonFormField<Deck>(
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
                            ),
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
                                FocusScope.of(context).requestFocus(focus);
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
                        ))
                    : LoaderCentered();

                var bottomBarButtons = <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.format_bold),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.format_align_center),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.format_align_justify),
                    onPressed: () {},
                  )
                ];

                return Scaffold(
                    backgroundColor:
                        WidgetsBinding.instance.window.platformBrightness ==
                                Brightness.dark
                            ? Color(0xFF1F2025)
                            : null,
                    appBar: AppBar(
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
                                widget.flashcard?.id ?? null,
                                state.selectedDeck,
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
                          children: bottomBarButtons,
                        ),
                      ),
                    ),
                    body: state is FlashcardLoaded
                        ? ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(22),
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        DropdownButtonFormField<Deck>(
                                          onChanged: (Deck deck) {
                                            BlocProvider.of<FlashcardBloc>(
                                                    context)
                                                .add(SelectDeck(
                                                    deck, state.decks));
                                          },
                                          validator: (value) => value == null
                                              ? 'Deck is required'
                                              : null,
                                          hint: Text("Deck"),
                                          isExpanded: true,
                                          value: state.selectedDeck,
                                          items: state.decks.map((Deck deck) {
                                            return DropdownMenuItem<Deck>(
                                              value: deck,
                                              child: Text(deck.name),
                                            );
                                          }).toList(),
                                        ),
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
                          )
                        : LoaderCentered());
              },
            )));
  }

}
