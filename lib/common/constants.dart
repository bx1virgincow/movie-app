class Constants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYjA3YTI3MTViMmI1MzBjYTg2N2Q2Mzc5MzUxOTMzYyIsInN1YiI6IjY2NzA3MjRlNDRlODg1OWNhOTcwNTZkNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aLU-aGijzA6Vu4952FEgajSSnBkFzNYPrrrh1zedNfU';

  static const String endPoint = '$baseUrl/authentication';

  static const String popularMovieListEndPoint = '$baseUrl/movie/popular';

  static const String trendingMoviesEndpoint =
      '$baseUrl/trending/movie/day?language=en-US';

  static const String movieCastEndPoint = '$baseUrl/movie/';
}
