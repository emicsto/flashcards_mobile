import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/utils/http_dio.dart';

Future<List<CardModel>> getFlashcardsByDeckId(int deckId) async {
  var _dio = await getHttpClient();
//TODO Add pagination
  final response = await _dio.get('/decks/$deckId/flashcards');

  if (response.statusCode == 200) {
    return response.data.map((i) => CardModel.fromJson(i)).cast<CardModel>().toList();
  } else {
    throw Exception('Failed to load flashcards');
  }
}
