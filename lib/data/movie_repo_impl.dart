import 'dart:convert';
import 'dart:developer';

import 'package:movieapp/common/constants.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/domain/movie_repo.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/movie_model.dart';

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
}
