import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants.dart';

final storage = new FlutterSecureStorage();

Future<Dio> getHttpClient() async {
  var _accessToken = await storage.read(key: "accessToken");
  Dio dio = new Dio();
  dio.options.baseUrl = API_URL;

  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    options.headers["Authorization"] = "Bearer " + _accessToken;
  }));
  return dio;
}