import 'dart:convert';

import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/utils/http_dio.dart';


Future<List<CardModel>> getFlashcardsByDeckId(String deckId, int page) async {
  var dio = await getHttpClient();
  final response = await dio.get('/decks/$deckId/flashcards', queryParameters: {"page": page, "size": 6});

  if (response.statusCode == 200) {
    return response.data.map((card) => CardModel.fromJson(card)).cast<CardModel>().toList();
  } else {
    throw Exception('Failed to load flashcards');
  }
}

Future<void> saveFlashcards(String deckId, String flashcards) async {
  var dio = await getHttpClient();

  final response = await dio.post('/decks/$deckId/flashcards/import', data: jsonEncode({"flashcards": flashcards}));

  if (response.statusCode != 200) {
    throw Exception('Failed to import flashcards');
  }
}
