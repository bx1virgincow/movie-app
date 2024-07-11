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
  final MovieCastResponse movieCastResponse;
  OnLoadMovieCastState({required this.movieCastResponse});
}

final class MovieCastLoadedState extends MovieState{
  final MovieCastResponse movieCast;

  MovieCastLoadedState({required this.movieCast});
}

final class MovieErrorState extends MovieState{
  final String errorMessage;

  MovieErrorState({required this.errorMessage});
}