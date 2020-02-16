import 'dart:convert';

import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/utils/http_dio.dart';

Future<List<CardModel>> getFlashcardsByDeckId(int deckId, int page) async {
  var _dio = await getHttpClient();
  final response = await _dio.get('/decks/$deckId/flashcards', queryParameters: {"page": page, "size": 6});
  if (response.statusCode == 200) {
    return response.data.map((i) => CardModel.fromJson(i)).cast<CardModel>().toList();
  } else {
    throw Exception('Failed to load flashcards');
  }
}

Future<void> importFlashcards(int deckId, String flashcards) async {
  print(flashcards);
  var _dio = await getHttpClient();

  final response = await _dio.post('/decks/$deckId/flashcards/import', data: jsonEncode({"flashcards": flashcards}));

  if (response.statusCode != 200) {
    throw Exception('Failed to import flashcards');
  }
}
