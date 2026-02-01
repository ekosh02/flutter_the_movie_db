import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/API/base_url.dart';
import 'package:flutter_the_movie_db/types/movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Movie> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final response = await dio.get('/movie/popular');
      final movieResponse = MovieResponse.fromJson(response.data);
      setState(() => _movies = movieResponse.results);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildMovieItem(Movie movie) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1.5,
            child: Image.network(
              'https://image.tmdb.org/t/p/original${movie.posterPath}',
              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.movie, size: 50, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            movie.releaseDate,
            maxLines: 1,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              const SizedBox(width: 2),
              Text(
                maxLines: 1,
                movie.voteAverage.toStringAsFixed(1),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _movies.isEmpty
          ? const Center(child: Text('No movies found'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        for (var i = 0; i < _movies.length; i += 2)
                          _buildMovieItem(_movies[i]),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        for (var i = 1; i < _movies.length; i += 2)
                          _buildMovieItem(_movies[i]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
