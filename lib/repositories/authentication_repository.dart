import 'dart:convert';
import 'package:flashcards/models/token_pair.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/utils/http_dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class AuthenticationRepository {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  Future<void> sendIdToken(String idToken) async {
    var _dio = await getHttpClient();

    final response = await _dio.post("/auth/token/sign-in",
        data: json.encode({"token": idToken}));

    if (response.statusCode == 200) {
      var tokenPair = TokenPair.fromJson(response.data);

      await storage.write(key: "accessToken", value: tokenPair.accessToken);
      await storage.write(key: "refreshToken", value: tokenPair.refreshToken);

      await getUserInfo();
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
      await storage.write(key: "pictureUrl", value: user.pictureUrl ?? "");
    } else {
      throw Exception('Failed to get user info');
    }
  }

  Future<void> deleteRefreshToken() async {
    var dio = await getHttpClient();
    var refreshToken = await storage.read(key: "refreshToken");
    dio.post("/auth/logout",
        data: json.encode({"refresh_token": refreshToken}));
  }

  Future<void> loginWithGoogle() async {
      var result = await googleSignIn.signIn();
      var googleKey = await result?.authentication;
      await sendIdToken(googleKey?.idToken);
  }

  Future<void> signInSilently() async {
    var result = await googleSignIn.signInSilently();
    var googleKey = await result?.authentication;
    await sendIdToken(googleKey?.idToken);
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await deleteRefreshToken();
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }

  Future<bool> hasToken() async {
    return await storage.read(key: "accessToken") == null ? false : true;
  }

  Future<void> deleteAllTokens() async {
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }
}
