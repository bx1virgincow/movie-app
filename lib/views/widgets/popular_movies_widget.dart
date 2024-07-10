import 'package:flutter/material.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/common/date_formatter.dart';
import 'package:movieapp/domain/models/movie_model.dart';

class PopularMovieScreen extends StatelessWidget {
  final Movie movie;
  final IconData iconData;
  final VoidCallback onTap;
  const PopularMovieScreen({
    super.key,
    required this.movie,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                      height:  MediaQuery.of(context).size.width * .45/0.9385,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
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
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: MovieAppColor.movieTitleColor,
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                formatDate(movie.releaseDate),
                style: const TextStyle(
                  color: MovieAppColor.dateColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
