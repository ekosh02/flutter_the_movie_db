import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_the_movie_db/constants/external_urls.dart';

class MediaCard extends StatelessWidget {
  final String title;
  final String? posterPath;
  final String releaseDate;
  final double voteAverage;

  const MediaCard({
    super.key,
    required this.title,
    this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Poster(posterPath: posterPath),
          const SizedBox(height: 8),
          _Title(title: title),
          const SizedBox(height: 4),
          _Subtitle(text: releaseDate),
          const SizedBox(height: 4),
          _Rating(voteAverage: voteAverage),
        ],
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  final String? posterPath;
  const _Poster({this.posterPath});

  @override
  Widget build(BuildContext context) {
    final imageUrl = ExternalUrls.tmdbImage(posterPath);
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.movie, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String text;
  const _Subtitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}

class _Rating extends StatelessWidget {
  final double voteAverage;
  const _Rating({required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 14),
        const SizedBox(width: 2),
        _Subtitle(text: voteAverage.toStringAsFixed(1)),
      ],
    );
  }
}
