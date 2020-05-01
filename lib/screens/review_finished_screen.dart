import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewFinishedScreen extends StatelessWidget {
  const ReviewFinishedScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reviewedDeckHeader = Text(
      "Deck Reviewed",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1.4),
    );

    var reviewedDeckText = Text(
      "You reviewed all the cards in this deck",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15, letterSpacing: 1.4, fontWeight: FontWeight.w300),
    );


    return Center(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              reviewedDeckHeader,
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                child: reviewedDeckText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
