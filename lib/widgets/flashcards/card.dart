import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/repositories/card_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  var isFront = true;

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
      isFront = true;
      index++;
    });
  }

  previousCard() {
    setState(() {
      isFront = true;
      index--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CardModel>>(
        future: flashcards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
                onTap: () => reverseCard(),
                child: Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
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
                              isFront
                                  ? Text(
                                      snapshot.data[index].front,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )
                                  : Text(
                                      snapshot.data[index].back,
                                      style: TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(onPressed: () => previousCard(), child: Text("Previous"),),
                          RaisedButton(onPressed: () => nextCard(), child: Text("Next"),),
                        ],
                      )
                    ],
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
