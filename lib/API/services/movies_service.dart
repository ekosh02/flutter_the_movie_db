import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/types/movie.dart';

enum MovieCategory {
  popular('popular'),
  nowPlaying('now_playing'),
  topRated('top_rated'),
  upcoming('upcoming');

  final String value;
  const MovieCategory(this.value);
}

class MoviesService {
  static Future<MovieResponse> getMovies({
    MovieCategory category = MovieCategory.popular,
    int page = 1,
  }) async {
    final response = await dio.get(
      '/movie/${category.value}',
      queryParameters: {'page': page},
    );

    return MovieResponse.fromJson(response.data);
  }
}
