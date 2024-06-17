part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

class OnPopularMovieLoadEvent extends MovieEvent {}
