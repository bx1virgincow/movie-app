

import 'package:movieapp/common/results.dart';

abstract class MovieRepository{
  Future<Result> getPopularMovies();
}