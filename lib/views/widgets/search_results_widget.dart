import 'package:flutter/material.dart';
import 'package:movieapp/domain/models/movie_model.dart';

class SearchTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const SearchTile({
    required this.movie,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate),
      leading: Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
    );
  }
}
