import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/domain/models/cast_model.dart';
import 'package:movieapp/domain/models/movie_details.dart';
import 'package:movieapp/domain/models/movie_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepoImplementation _movieRepoImplementation;
  MovieBloc(this._movieRepoImplementation) : super(MovieLoadingState()) {
    on<OnPopularMovieLoadEvent>(onPopularMovieLoadEvent);
    on<OnLoadMovieCastEvent>(_onLoadMovieCastEvent);
    on<SearchMovieEvent>(_searchMovieEvent);
    on<GetMovieDetails>(_getMovieDetails);
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
        emit(PopularMoviesState(
            popularMovies: popularResponse.value,
            trendingMovies: trendingResponse.value));
      } else if (popularResponse is Success && trendingResponse is Success) {
        emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
      }
    } catch (e) {
      emit(MovieFaileToLoadState(errorMessage: 'errorMessage'));
    }
  }

  FutureOr<void> _onLoadMovieCastEvent(
      OnLoadMovieCastEvent event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoadingState());
      final movieCast = await _movieRepoImplementation.getCasts(event.movieId);
      if (movieCast is Success) {
        emit(MovieCastLoadedState(movieCast: movieCast.value));
      } else if (movieCast is Failed) {
        emit(MovieErrorState(errorMessage: movieCast.errorMessage));
      }
    } catch (e) {
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _searchMovieEvent(
      SearchMovieEvent event, Emitter<MovieState> emit) async {
    emit(MovieLoadingState());
    try {
      final searchResult =
          await _movieRepoImplementation.searchMovie(event.query);
      if (searchResult is Success) {
        final movies = searchResult.value;
        emit(SearchMovieState(movieResponse: movies));
      } else {
        emit(MovieFaileToLoadState(errorMessage: searchResult.value));
      }
    } catch (e) {
      emit(MovieFaileToLoadState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetails event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoadingState());
      await Future.delayed(const Duration(milliseconds: 500));

      final detailResponse =
          await _movieRepoImplementation.getMovieDetail(event.movieId);

      if (detailResponse is Success) {
        emit(MovieDetailState(movieDetail: detailResponse.value));
      } else if (detailResponse is Failed) {
        emit(MovieFaileToLoadState(errorMessage: detailResponse.errorMessage));
      }
    } catch (e) {
      emit(MovieErrorState(errorMessage: e.toString()));
    }
  }
}
