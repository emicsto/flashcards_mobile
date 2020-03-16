import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/screens/empty_deck.dart';
import 'package:flashcards/utils/assessment.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flashcards/utils/extended_flip_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/counter/bloc.dart';
import 'blocs/flashcards/bloc.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class CardScreen extends StatefulWidget {
  final String deckId;

  CardScreen({Key key, this.deckId}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Future<List<CardModel>> flashcards;
  List<CardModel> cards = [];

  //TODO: implement lazy loading
  loadNextPage(int index, int page) async {
//    BlocProvider.of<FlashcardsBloc>(context)
//        .add(LoadFlashcards(widget.deckId, page));
//    BlocProvider.of<CounterBloc>(context).add(DoAction(index, page));

  }

  nextCard(int index, int page) {
    BlocProvider.of<CounterBloc>(context).add(DoAction(index + 1, page));
    setState(() {
      if(!cardKey.currentState.isFront) {
        cardKey.currentState.setFront();
      }
    });
  }

  //TODO implement correctly
  assignAssessment(Assessment assessment, int index, int page) {
    nextCard(index, page);
  }

  Widget buildScreen(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[buildCard(context), buildButtons()],
    ));
  }

  Widget buildButtons() {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {},
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterInitial) {
            return Expanded(
//      TODO: fix
              child: false
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () => assignAssessment(
                              Assessment.again, state.index, state.page),
                          child: Text("Again"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(
                              Assessment.hard, state.index, state.page),
                          child: Text("Hard"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(
                              Assessment.easy, state.index, state.page),
                          child: Text("Easy"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(
                              Assessment.good, state.index, state.page),
                          child: Text("Good"),
                        ),
                      ],
                    ),
            );
          }
          return CircularProgressIndicatorCentered();
        },
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state is CounterInitial) {

//          if (state.index >= cards.length - 3) {
//            loadNextPage(state.index, state.page + 1);
//          }
        }
      },
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterInitial) {

            return Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlipCard(
                    speed: 350,
                    key: cardKey,
                    direction: FlipDirection.HORIZONTAL,
                    front: Flashcard(
                      text: Text(
                        cards.isNotEmpty ? cards[state.index].front : "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    back: Flashcard(
                      text: Text(
                        cards.isNotEmpty ? cards[state.index].back : "",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicatorCentered();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<FlashcardsBloc, FlashcardsState>(
      listener: (context, state) {
        if (state is FlashcardsLoaded) {
          cards.addAll(state.flashcards);
        }
      },
      child: BlocBuilder<FlashcardsBloc, FlashcardsState>(
        builder: (context, state) {
          if (state is NoFlashcards) {
            return EmptyDeck();
          } else if (state is FlashcardsLoaded) {
            return buildScreen(context);
          } else {
            return CircularProgressIndicatorCentered();
          }
        },
      ),
    ));
  }
}
