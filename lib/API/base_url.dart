import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/API/constants.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    headers: {'accept': 'application/json', 'content-type': 'application/json'},
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ),
);

void setApiAccessKey(String apiAccessKey) {
  dio.options.headers['Authorization'] = 'Bearer $apiAccessKey';
}

void clearApiAccessKey() {
  dio.options.headers.remove('Authorization');
}
