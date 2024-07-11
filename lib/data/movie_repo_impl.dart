import 'dart:convert';
import 'dart:developer';

import 'package:movieapp/common/constants.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/domain/models/cast_model.dart';
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
          log('List res: $res');
          return Success(value: res);
        } else {
          final res = MovieResponse.fromJson(jsonResponse);
          log('json res: $res');
          return Success(value: res);
        }
      } else {
        log('failed: ${response.body}');
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
          log('trending list res: $res');
          return Success(value: res);
        } else {
          final res = MovieResponse.fromJson(jsonResponse);
          log('trending json res: $res');
          return Success(value: res);
        }
      } else {
        log('trending failed: ${response.body}');
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
          log('at this point : $jsonResponse');
          final res = MovieCastResponse.fromJson(jsonResponse);
          return Success(value: res);
        } else if (jsonResponse is List) {
          log('at that point');
          final res =
              jsonResponse.map((e) => MovieCastResponse.fromJson(e)).toList();
          return Success(value: res);
        } else {
          log('errr: $jsonResponse');
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
        log('Failed to search movies: ${response.statusCode}');
        return Failed(
            errorMessage: 'Failed to search movies',
            value: response.statusCode);
      }
    } catch (e) {
      log('Exception occurred: $e');
      return Failed(errorMessage: 'Exception occurred', value: e);
    }
  }
}
