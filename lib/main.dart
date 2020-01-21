import 'package:flashcards/flashcards_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          accentColor: Colors.cyan),
      darkTheme:
          ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.orange),
      home: MyHomePage(title: 'Home'),
    );
  }
}
