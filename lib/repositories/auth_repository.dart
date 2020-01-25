import 'dart:convert';
import 'package:flashcards/models/token_pair.dart';
import 'package:flashcards/utils/HttpDio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> sendIdToken(String idToken) async {
  var _dio = await getHttpClient();

  final response = await _dio.post("/auth/token/sign-in",
      data: json.encode({"token": idToken})
  );

  if (response.statusCode == 200) {
    final storage = new FlutterSecureStorage();

    Map tokenPairMap = jsonDecode(response.data);
    var tokenPair = TokenPair.fromJson(tokenPairMap);

    await storage.write(key: "accessToken", value: tokenPair.accessToken);
    await storage.write(key: "refreshToken", value: tokenPair.refreshToken);

  } else {
    print(response.statusCode);
  }
}
