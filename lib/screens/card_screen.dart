import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flashcards/utils/assessment.dart';
import 'package:flashcards/utils/extended_flip_card_state.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class CardScreen extends StatefulWidget {
  final int id;

  CardScreen({Key key, this.id}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  Future<List<CardModel>> flashcards;
  int index = 0;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    flashcards = getFlashcardsByDeckId(widget.id);
  }

  reverseCard() {
    setState(() {
      isFront = !isFront;
    });
  }

  nextCard() {
    setState(() {
      cardKey.currentState.setFront();
      isFront = true;
      index++;
    });
  }

  //TODO implement correctly
  assignAssessment(Assessment assessment) {
    nextCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<CardModel>>(
            future: flashcards,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var buttonsRow = Expanded(
                  child: isFront
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () =>
                                  assignAssessment(Assessment.again),
                              child: Text("Again"),
                            ),
                            RaisedButton(
                              onPressed: () =>
                                  assignAssessment(Assessment.hard),
                              child: Text("Hard"),
                            ),
                            RaisedButton(
                              onPressed: () =>
                                  assignAssessment(Assessment.easy),
                              child: Text("Easy"),
                            ),
                            RaisedButton(
                              onPressed: () =>
                                  assignAssessment(Assessment.good),
                              child: Text("Good"),
                            ),
                          ],
                        ),
                );

                var expanded = Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlipCard(
                        speed: 350,
                        key: cardKey,
                        onFlip: reverseCard,
                        direction: FlipDirection.HORIZONTAL,
                        front: Flashcard(
                          text: Text(
                            snapshot.data[index].front,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                        back: Flashcard(
                          text: Text(
                            snapshot.data[index].back,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                return GestureDetector(
                    child: Center(
                  child: Column(
                    children: <Widget>[expanded, buttonsRow],
                  ),
                ));
              }
              return CircularProgressIndicatorCentered();
            }));
  }
}
