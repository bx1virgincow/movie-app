import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/models/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepoImplementation _movieRepoImplementation;
  MovieBloc(this._movieRepoImplementation) : super(MovieLoadingState()) {
    on<OnPopularMovieLoadEvent>(onPopularMovieLoadEvent);
  }

  //popular movie load event
  FutureOr<void> onPopularMovieLoadEvent(
      OnPopularMovieLoadEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoadingState());
      final response = await _movieRepoImplementation.getPopularMovies();
      if (response is Success) {
        log('bloc success res: ${response.value}');
        emit(PopularMoviesState(popularMovies: response.value));
      } else if (response is Failed) {
        log('bloc failed res: ${response.value}');

        emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
      }
    } catch (e) {
      log('bloc exception: $e');

      emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
    }
  }
}
