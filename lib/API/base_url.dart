import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/API/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final Dio dio =
    Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'accept': 'application/json',
            'content-type': 'application/json',
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false,
          maxWidth: 90,
        ),
      );

void setApiAccessKey(String apiAccessKey) {
  dio.options.headers['Authorization'] = 'Bearer $apiAccessKey';
}

void clearApiAccessKey() {
  dio.options.headers.remove('Authorization');
}
