import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/domain/models/cast_model.dart';
import 'package:movieapp/domain/models/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepoImplementation _movieRepoImplementation;
  MovieBloc(this._movieRepoImplementation) : super(MovieLoadingState()) {
    on<OnPopularMovieLoadEvent>(onPopularMovieLoadEvent);
    on<OnLoadMovieCastEvent>(_onLoadMovieCastEvent);
  }

  //popular movie load event
  FutureOr<void> onPopularMovieLoadEvent(
      OnPopularMovieLoadEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoadingState());
      final popularResponse = await _movieRepoImplementation.getPopularMovies();
      final trendingResponse =
          await _movieRepoImplementation.getTrendingMovies();
      if (popularResponse is Success && trendingResponse is Success) {
        log('bloc success');
        emit(PopularMoviesState(
            popularMovies: popularResponse.value,
            trendingMovies: trendingResponse.value));
      } else if (popularResponse is Success && trendingResponse is Success) {
        log('bloc failed res');
        emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
      }
    } catch (e) {
      log('bloc exception: $e');

      emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
    }
  }

  FutureOr<void> _onLoadMovieCastEvent(
      OnLoadMovieCastEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoadingState());
      final movieCast = await _movieRepoImplementation.getCasts(event.movieId);
      if (movieCast is Success) {
        log('movie cast success');
        emit(MovieCastLoadedState(movieCast: movieCast.value));
      } else if (movieCast is Failed) {
        log('movie cast failed');
        emit(MovieErrorState(errorMessage: movieCast.errorMessage));
      }
    } catch (e) {
      log('movie cast exception');
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }
}
