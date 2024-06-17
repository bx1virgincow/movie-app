import 'dart:developer';

import 'package:movieapp/common/constants.dart';
import 'package:movieapp/common/results.dart';
import 'package:movieapp/domain/movie_repo.dart';
import 'package:http/http.dart' as http;

class MovieRepoImplementation implements MovieRepository {
  @override
  Future<Result> getMovies() async {
    try {
      Loading(value: 'Loading...');
      final response = await http.get(
          Uri.parse(
            Constants.endPoint,
          ),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Authorization': 'Bearer ${Constants.bearerToken}',
          });

      if (response.statusCode == 200) {
        log('success: ${response.body}');
        return Success(value: response.body);
      } else if (response.statusCode == 401) {
        log('failed: ${response.body}');
        return Failed(
          errorMessage: 'unauthorized',
          value: response.body,
        );
      } else {
        log('else: ${response.body}');
        return Failed(
          errorMessage: 'errorMessage',
          value: response.body,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
