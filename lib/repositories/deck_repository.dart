import 'package:flashcards/utils/http_dio.dart';
import 'package:flashcards/models/deck.dart';

import '../main.dart';

Future<List<Deck>> fetchDecks() async {
  var _dio = await getHttpClient();
  final response = await _dio.get('/decks');

  if (response.statusCode == 200) {
    return response.data
        .map((i) => Deck.fromJson(i)).cast<Deck>()
        .toList();
  } else {
    throw Exception('Failed to load decks');
  }
}
