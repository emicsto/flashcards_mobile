import 'dart:convert';

import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/utils/http_dio.dart';

class FlashcardRepository {
  Future<List<CardModel>> getFlashcardsByDeckId(
      {String deckId, int page = 0}) async {
    var dio = await getHttpClient();
    final response = await dio.get('/decks/$deckId/flashcards',
        queryParameters: {"page": page});

    if (response.statusCode == 200) {
      return response.data
          .map((card) => CardModel.fromJson(card))
          .cast<CardModel>()
          .toList();
    } else {
      throw Exception('Failed to load flashcards');
    }
  }

  Future<void> saveFlashcards(String deckId, String flashcards) async {
    var dio = await getHttpClient();

    final response = await dio.post('/decks/$deckId/flashcards/import',
        data: jsonEncode({"flashcards": flashcards}));

    if (response.statusCode != 200) {
      throw Exception('Failed to import flashcards');
    }
  }

  Future<void> addFlashcard(String deckId, String front, String back) async {
    var dio = await getHttpClient();

    final response = await dio.post('/flashcards',
        data: jsonEncode({"deckId": deckId, "front": front, "back": back}));

    if (response.statusCode != 200) {
      throw Exception('Failed to create flashcard');
    }
  }

  Future<void> updateFlashcard(String flashcardId, String deckId, String front, String back) async {
    var dio = await getHttpClient();

    final response = await dio.put('/flashcards',
        data: jsonEncode({"id": flashcardId, "deckId": deckId, "front": front, "back": back}));

    if (response.statusCode != 200) {
      throw Exception('Failed to update flashcard');
    }
  }
}
