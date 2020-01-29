import 'dart:convert';
import 'package:flashcards/models/token_pair.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/utils/http_dio.dart';

import '../main.dart';

Future<void> sendIdToken(String idToken) async {
  var _dio = await getHttpClient();

  final response = await _dio.post("/auth/token/sign-in",
      data: json.encode({"token": idToken}));

  if (response.statusCode == 200) {
    var tokenPair = TokenPair.fromJson(response.data);

    await storage.write(key: "accessToken", value: tokenPair.accessToken);
    await storage.write(key: "refreshToken", value: tokenPair.refreshToken);

    getUserInfo();
  } else {
    throw Exception('Failed to retrieve tokens');
  }
}

Future<void> getUserInfo() async {
  var _dio = await getHttpClient();

  final response = await _dio.get("/auth/me");

  if (response.statusCode == 200) {
    var user = User.fromJson(response.data);

    await storage.write(key: "name", value: user.name);
    await storage.write(key: "email", value: user.email);
    await storage.write(key: "pictureUrl", value: user.pictureUrl);
  } else {
    throw Exception('Failed to get user info');
  }
}
