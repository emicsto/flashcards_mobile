import 'dart:convert';
import 'package:flashcards/models/token_pair.dart';
import 'package:http/http.dart' as http;
import 'package:flashcards/utils/constants.dart' as Constants;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> sendIdToken(String idToken) async {
  print(Constants.API_URL + '/auth/token/sign-in');
  final response = await http.post(
      Constants.API_URL + '/auth/token/sign-in',
      headers: {"Content-Type": "application/json"},
      body: json.encode({"token": idToken})
  );

  if (response.statusCode == 200) {
    final storage = new FlutterSecureStorage();

    Map tokenPairMap = jsonDecode(response.body);
    var tokenPair = TokenPair.fromJson(tokenPairMap);

    await storage.write(key: "accessToken", value: tokenPair.accessToken);
    await storage.write(key: "refreshToken", value: tokenPair.refreshToken);

  } else {
    print(response.statusCode);
  }
}
