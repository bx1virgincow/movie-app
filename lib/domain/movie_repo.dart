

import 'package:movieapp/common/results.dart';

abstract class MovieRepository{
  Future<Result> getPopularMovies();

  Future<Result> getTrendingMovies();

  Future<Result> getCasts(int id);
}