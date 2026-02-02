import 'package:dio/dio.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/API/constants.dart';
import 'package:flutter_the_movie_db/types/account.dart';

class AccountService {
  static Future<RequestTokenResponse> createRequestToken({
    required String apiAccessKey,
  }) async {
    final response = await dio.get(
      endpoints['/authentication/token/new']!,
      options: Options(headers: {'Authorization': 'Bearer $apiAccessKey'}),
    );
    return RequestTokenResponse.fromJson(response.data);
  }

  static Future<SessionResponse> createSession({
    required String apiAccessKey,
    required String requestToken,
  }) async {
    final response = await dio.get(
      endpoints['/authentication/session/new']!,
      queryParameters: {'request_token': requestToken},
      options: Options(headers: {'Authorization': 'Bearer $apiAccessKey'}),
    );
    return SessionResponse.fromJson(response.data);
  }
}
