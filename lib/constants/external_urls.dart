class ExternalUrls {
  static String tmdbAuth(String? requestToken) {
    if (requestToken == null || requestToken.isEmpty) return '';
    return 'https://www.themoviedb.org/authenticate/$requestToken';
  }

  static String tmdbImage(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
