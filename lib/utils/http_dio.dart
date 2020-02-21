import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flashcards/models/access_token.dart';

import '../main.dart';

import '../env.dart';


Future<Dio> getHttpClient() async {
  var _baseUrl = environment["baseUrl"];
  var _accessToken = await storage.read(key: "accessToken");
  Dio dio = new Dio();
  Dio tokenDio = Dio();

  dio.options.baseUrl = _baseUrl;
  tokenDio.options.baseUrl = _baseUrl;
  dio.interceptors.requestLock;
  if (_accessToken != null) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        await addAccessTokenToHeader(options, _accessToken);
      },
      onError: (DioError error) async {
        if (error.response?.statusCode == 401) {
          return await refreshToken(error, dio, tokenDio);
        }
        return error;
      },
    ));
  }

  return dio;
}

Future<Object> refreshToken(DioError error, Dio dio, Dio tokenDio) async {
  RequestOptions options = error.response.request;

  var refreshToken = await storage.read(key: "refreshToken");
  await storage.delete(key: "accessToken");

  if (refreshToken != null) {
    lockRequest(dio);

    return tokenDio
        .post("/auth/token/refresh",
            data: json.encode({"refresh_token": refreshToken}))
        .then((response) async {
      var accessToken = AccessToken.fromJson(response.data);
      await storage.write(key: "accessToken", value: accessToken.value);
    }).whenComplete(() {
      unlockRequest(dio);
    }).then((_) {
      return dio.request(options.path, options: options);
    });
  }
  return error;
}

void unlockRequest(Dio dio) {
  dio.unlock();
  dio.interceptors.responseLock.unlock();
  dio.interceptors.errorLock.unlock();
}

void lockRequest(Dio dio) {
  dio.lock();
  dio.interceptors.responseLock.lock();
  dio.interceptors.errorLock.lock();
}

Future addAccessTokenToHeader(RequestOptions options, String accessToken) async {
  accessToken = "Bearer " + accessToken;
  options.headers["Authorization"] = accessToken;
}
