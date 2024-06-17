import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';

class PopularMovieScreen extends StatelessWidget {
  final MovieBloc movieBloc;
  final Movie movie;
  final IconData iconData;
  const PopularMovieScreen({
    super.key,
    required this.movieBloc,
    required this.movie,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .45,
                    height: 200,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                          child: Text(
                        'Failed to load picture',
                      )),
                      // loadingBuilder: (context, child, loadingProgress) =>
                      //     const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            Text(movie.releaseDate),
          ],
        ),
      ),
    );
  }
}
