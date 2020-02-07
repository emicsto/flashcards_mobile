import 'package:flashcards/widgets/flashcards/card.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  final int id;

  CardScreen({Key key, this.id}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
        ),
      ),
      body: CardWidget(id: widget.id),
    );
  }
}
