import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyDeckScreen extends StatelessWidget {
  const EmptyDeckScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emptyDeckHeader = Text(
      "Empty Deck",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 1.4),
    );

    var emptyDeckText = Text(
      "Looks like you don't have any cards to review",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15, letterSpacing: 1.4, fontWeight: FontWeight.w300),
    );

    var emptyDeckImage = SizedBox.fromSize(
      child: SvgPicture.asset(
        'images/blank.svg',
      ),
      size: Size(280.0, 280.0),
    );

    return Center(
      child: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            emptyDeckImage,
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: emptyDeckHeader,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
              child: emptyDeckText,
            ),
          ],
        ),
      ),
    );
  }
}
