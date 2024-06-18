part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieLoadingState extends MovieState {}

final class PopularMoviesState extends MovieState {
  final MovieResponse popularMovies;
  final MovieResponse trendingMovies;
  PopularMoviesState({
    required this.popularMovies,
    required this.trendingMovies,
  });
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


final class OnLoadMovieCastState extends MovieState{
  final CastModel castModel;
  OnLoadMovieCastState({required this.castModel});
}