import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/widgets/API/constants.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    headers: {'accept': 'application/json'},
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ),
);

void setApiKey(String apiKey) {
  dio.options.headers['Authorization'] = 'Bearer $apiKey';
}

void clearApiKey() {
  dio.options.headers.remove('Authorization');
}
