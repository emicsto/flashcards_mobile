import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flashcards/utils/assessment.dart';
import 'package:flashcards/utils/extended_flip_card_state.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:flashcards/screens/empty_deck.dart';
import 'package:flashcards/widgets/layouts/circular_progress_indicator_centered.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

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
  int index = 0;
  bool isFront = true;
  final firstPage = 0;
  int nextPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadFlashcards(firstPage);
  }
      loadFlashcards(int page) async {
        if (mounted) {
          setState(() => isLoading = true);
        }

        var newCards = await getFlashcardsByDeckId(widget.deckId, page);

        if (mounted) {
          setState(() {
            isLoading = false;
            cards.addAll(newCards);
            nextPage++;
          });
        }
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
      if (index >= cards.length - 3) {
        loadFlashcards(nextPage);
      }
    });
  }

  //TODO implement correctly
  assignAssessment(Assessment assessment) {
    nextCard();
  }

  Widget buildScreen() {
    return Center(
        child: Column(
      children: <Widget>[buildCard(), buildButtons()],
    ));
  }

  Widget buildButtons() {
    return Expanded(
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
  }

  Widget buildCard() {
    return Expanded(
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
                cards.isNotEmpty ? cards[index].front : "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            back: Flashcard(
              text: Text(
                cards.isNotEmpty ? cards[index].back : "",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading && index == 0
            ? CircularProgressIndicatorCentered()
            : cards.isEmpty ? EmptyDeck() : buildScreen());
  }
}
