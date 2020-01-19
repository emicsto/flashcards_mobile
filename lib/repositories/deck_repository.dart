import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flashcards/models/deck.dart';

Future<List<Deck>> fetchDecks() async {
  final response = await http.get('https://app-flashcards.herokuapp.com/api/decks');

  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((i) => Deck.fromJson(i))
        .toList();
  } else {
    throw Exception('Failed to load decks');
  }
}
