import 'package:flashcards/flashcards_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}


