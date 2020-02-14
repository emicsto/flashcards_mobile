import 'package:flutter/material.dart';

class Flashcard extends StatelessWidget {
  const Flashcard({
    Key key,
    @required this.text,
  }) : super(key: key);

  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 350,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            text,
          ],
        ),
      ),
    );
  }
}