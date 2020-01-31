import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flashcards/models/access_token.dart';

import '../main.dart';
import 'constants.dart';

Future<Dio> getHttpClient() async {
  var _accessToken = await storage.read(key: "accessToken");
  Dio dio = new Dio();
  Dio tokenDio = Dio();

  dio.options.baseUrl = API_URL;
  tokenDio.options.baseUrl = API_URL;
  dio.interceptors.requestLock;
  if (_accessToken != null) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        options.headers["Authorization"] =
            "Bearer " + await storage.read(key: "accessToken");
      },
      onError: (DioError error) async {
        if (error.response?.statusCode == 401) {
          RequestOptions options = error.response.request;

          var refreshToken = await storage.read(key: "refreshToken");
          await storage.delete(key: "accessToken");

          if (refreshToken != null) {
            dio.lock();
            dio.interceptors.responseLock.lock();
            dio.interceptors.errorLock.lock();

            return tokenDio
                .post("/auth/token/refresh",
                    data: json.encode({"refresh_token": refreshToken}))
                .then((response) async {
              var accessToken = AccessToken.fromJson(response.data);
              await storage.write(key: "accessToken", value: accessToken.value);
            }).whenComplete(() {
              dio.unlock();
              dio.interceptors.responseLock.unlock();
              dio.interceptors.errorLock.unlock();
            }).then((_) {
              return dio.request(options.path, options: options);
            });
          }
        }
        return error;
      },
    ));
  }

  return dio;
}
