import 'dart:convert';
import 'dart:developer';

import 'package:movieapp/common/constants.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/domain/models/cast_model.dart';
import 'package:movieapp/domain/models/movie_details.dart';
import 'package:movieapp/domain/repository/movie_repo.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/domain/models/movie_model.dart';

class MovieRepoImplementation implements MovieRepository {
  //popular movies
  @override
  Future<Result> getPopularMovies() async {
    try {
      Loading(value: 'Loading...');
      final response = await http.get(
          Uri.parse(
            Constants.popularMovieListEndPoint,
          ),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer ${Constants.bearerToken}',
          });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          final res =
              jsonResponse.map((e) => MovieResponse.fromJson(e)).toList();

          return Success(value: res);
        } else {
          final res = MovieResponse.fromJson(jsonResponse);
          return Success(value: res);
        }
      } else {
        return Failed(
          errorMessage: 'unauthorized',
          value: response.body,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //trending movies request
  @override
  Future<Result> getTrendingMovies() async {
    try {
      Loading(value: 'Loading...');
      final response = await http.get(
          Uri.parse(
            Constants.trendingMoviesEndpoint,
          ),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer ${Constants.bearerToken}',
          });

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse is List) {
          final res =
              jsonResponse.map((e) => MovieResponse.fromJson(e)).toList();

          return Success(value: res);
        } else {
          final res = MovieResponse.fromJson(jsonResponse);

          return Success(value: res);
        }
      } else {
        return Failed(
          errorMessage: 'unauthorized',
          value: response.body,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //fetch cast
  @override
  Future<Result> getCasts(int movieId) async {
    try {
      final response = await http.get(
          Uri.parse(
            '${Constants.movieCastEndPoint}$movieId/credits?api_key=${Constants.bearerToken}',
          ),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer ${Constants.bearerToken}',
          });
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          final res = MovieCastResponse.fromJson(jsonResponse);
          return Success(value: res);
        } else if (jsonResponse is List) {
          final res =
              jsonResponse.map((e) => MovieCastResponse.fromJson(e)).toList();
          return Success(value: res);
        } else {
          return Failed(errorMessage: 'errorMessage', value: jsonResponse);
        }
      }
      return Success(value: 'success');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Result> searchMovie(String query) async {
    try {
      log('query: $query');
      final response = await http.get(
          Uri.parse(
            'https://api.themoviedb.org/3/search/movie?query=$query&api_key=bb07a2715b2b530ca867d6379351933c',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Constants.bearerToken}'
          });

      if (response.statusCode == 200) {
        final searchData = jsonDecode(response.body);
        final movieResponse = MovieResponse.fromJson(searchData);
        return Success(value: movieResponse);
      } else {
        return Failed(
            errorMessage: 'Failed to search movies',
            value: response.statusCode);
      }
    } catch (e) {
      return Failed(errorMessage: 'Exception occurred', value: e);
    }
  }

  @override
  Future<Result> getMovieDetail(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/movie/$movieId?api_key=bb07a2715b2b530ca867d6379351933c'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          final responseData = MovieDetail.fromJson(jsonResponse);

          return Success(value: responseData);
        } else if (jsonResponse is List) {
          final responseData =
              jsonResponse.map((e) => MovieDetail.fromJson(e)).toList();

          return Success(value: responseData);
        }
      }

      return Success(value: 'success');
    } catch (e) {
      return Failed(errorMessage: 'Failed to fetch movie details', value: e);
    }
  }

  @override
  Future<Result> getMovieTrailer(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=bb07a2715b2b530ca867d6379351933c';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final videos = data['results'];

      for (var video in videos) {
        if (video['type'] == 'Trailer' && video['site'] == 'YouTube') {
          final videoKey = video['key'];
          return Success(value: videoKey);
        }
      }
      throw Exception('Trailer not found');
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
