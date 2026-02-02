import 'package:flutter/material.dart';
import 'package:flutter_the_movie_db/API/services/movies_service.dart';
import 'package:flutter_the_movie_db/types/movie.dart';
import 'package:flutter_the_movie_db/widgets/media_card/media_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Movie> _movies = [];
  bool _isLoading = true;
  bool _isFetchingMore = false;
  int _currentPage = 1;
  int _totalPages = 1;

  Future<void> _loadMovies() async {
    try {
      final moviesResponse = await MoviesService.getMovies(
        category: MovieCategory.popular,
      );
      setState(() {
        _movies = moviesResponse.results;
        _currentPage = moviesResponse.page;
        _totalPages = moviesResponse.totalPages;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMoreMovies() async {
    setState(() => _isFetchingMore = true);
    try {
      final moviesResponse = await MoviesService.getMovies(
        category: MovieCategory.popular,
        page: _currentPage + 1,
      );
      setState(() {
        _movies.addAll(moviesResponse.results);
        _currentPage = moviesResponse.page;
      });
    } finally {
      setState(() => _isFetchingMore = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        _currentPage < _totalPages) {
      _loadMoreMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMovieItem(Movie movie) {
    return MediaCard(
      title: movie.title,
      posterPath: movie.posterPath,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _movies.isEmpty
          ? const Center(child: Text('No movies found'))
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount:
                  (_movies.length / 2).ceil() + (_isFetchingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == (_movies.length / 2).ceil()) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final int firstIndex = index * 2;
                final int secondIndex = firstIndex + 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildMovieItem(_movies[firstIndex])),
                    const SizedBox(width: 10),
                    Expanded(
                      child: secondIndex < _movies.length
                          ? _buildMovieItem(_movies[secondIndex])
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
