import 'package:dio/dio.dart';
import 'package:flashcards/router.dart';
import 'package:flashcards/screens/login.dart';

import '../main.dart';
import 'constants.dart';

Future<Dio> getHttpClient() async {
  var _accessToken = await storage.read(key: "accessToken");
  Dio dio = new Dio();
  dio.options.baseUrl = API_URL;

  if (_accessToken != null) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        options.headers["Authorization"] = "Bearer " + _accessToken;
      },
      onResponse: (Response response) {
        //TODO implement refresh token request
        if (response.statusCode == 403) {
          navigatorKey.currentState.pushNamed(LoginViewRoute);
        }
      },
    ));
  }

  return dio;
}
