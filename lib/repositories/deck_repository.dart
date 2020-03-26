import 'dart:convert';

import 'package:flashcards/utils/http_dio.dart';
import 'package:flashcards/models/deck.dart';

class DeckRepository {
  Future<List<Deck>> fetchDecks() async {
    var _dio = await getHttpClient();
    final response = await _dio.get('/decks');

    if (response.statusCode == 200) {
      return response.data.map((i) => Deck.fromJson(i)).cast<Deck>().toList();
    } else {
      throw Exception('Failed to load decks');
    }
  }

  Future<void> addDeck(String name) async {
    var dio = await getHttpClient();

    final response = await dio.post('/decks', data: jsonEncode({"name": name}));

    if (response.statusCode != 200) {
      throw Exception('Failed to add deck');
    }
  }

  Future<void> delete(String id) async {
    var dio = await getHttpClient();

    final response = await dio.delete('/decks/$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete deck');
    }
  }
}
