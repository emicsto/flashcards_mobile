import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flashcards/utils/assessment.dart';
import 'package:flashcards/utils/extended_flip_card_state.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class CardWidget extends StatefulWidget {
  final int id;

  CardWidget({Key key, this.id}) : super(key: key);

  @override
  CardWidgetState createState() {
    return CardWidgetState();
  }
}

class CardWidgetState extends State<CardWidget> {
  var flashcards;
  var index = 0;
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
    return FutureBuilder<List<CardModel>>(
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
                          onPressed: () => assignAssessment(Assessment.again),
                          child: Text("Again"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(Assessment.hard),
                          child: Text("Hard"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(Assessment.easy),
                          child: Text("Easy"),
                        ),
                        RaisedButton(
                          onPressed: () => assignAssessment(Assessment.good),
                          child: Text("Good"),
                        ),
                      ],
                    ),
            );

            var card = Expanded(
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
                    front: Container(
                      height: 500,
                      width: 350,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].front,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                    back: Container(
                      height: 500,
                      width: 350,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              snapshot.data[index].back,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

            return GestureDetector(
                child: Center(
              child: Column(
                children: <Widget>[card, buttonsRow],
              ),
            ));
          }
          return Center(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[CircularProgressIndicator()],
          ));
        });
  }
}
