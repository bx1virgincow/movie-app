part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

class OnPopularMovieLoadEvent extends MovieEvent {}

class OnLoadMovieCastEvent extends MovieEvent {
  final int movieId;
  OnLoadMovieCastEvent({required this.movieId});
}
