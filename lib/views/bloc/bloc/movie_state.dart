part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieLoadingState extends MovieState {}

final class PopularMoviesState extends MovieState {
  final MovieResponse popularMovies;
  PopularMoviesState({required this.popularMovies});
}

final class FreeToWatchMovieState extends MovieState {}

final class ErrorPageState extends MovieState {
  final String errorMessage;
  ErrorPageState({required this.errorMessage});
}

final class MovieFaileToLoadState extends MovieState {
  final String errorMessage;
  MovieFaileToLoadState({required this.errorMessage});
}
