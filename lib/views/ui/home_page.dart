import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/ui/details_page.dart';
import 'package:movieapp/views/widgets/popular_movies_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieBloc(MovieRepoImplementation())..add(OnPopularMovieLoadEvent()),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: MovieAppColor.homepageColor,
          child: Column(
            children: [
              // Welcome text and user
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Hello',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xff3A3A3A)),
                      ),
                      // Space
                      SizedBox(width: 10),
                      Image(
                        image: AssetImage('assets/images/mdi_hand-wave.png'),
                      )
                    ],
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: MovieAppColor.avatarBgColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Image(
                          image: AssetImage('assets/images/bxs_user.png'))),
                ],
              ),

              // Bold text
              const SizedBox(height: 10),

              // Text
              const Text(
                'Millions of movies, TV shows to explore now.',
                style: TextStyle(
                  color: Color(0xff4D4C4C),
                  fontSize: 25,
                ),
              ),

              // Space
              const SizedBox(height: 10),

              // Search field
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: MovieAppColor.searchIconColor,
                    size: 30,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  hintText: 'Search for movies, tv show...',
                  hintStyle: const TextStyle(
                    color: MovieAppColor.searchIconColor,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: MovieAppColor.searchFieldColor,
                  filled: true,
                ),
              ),

              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesState) {
                    var popular = state;
                    var trending = state;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Space
                        const SizedBox(height: 20),

                        _movieHeaders(
                          movieTitle: 'What\'s Popular',
                          movieType: 'Streaming',
                        ),
                        const SizedBox(height: 10),
                        // Popular feeds
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: popular.popularMovies.results
                                  .map((movie) => PopularMovieScreen(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                movie: movie,
                                              ),
                                            ),
                                          );
                                        },
                                        movie: movie,
                                        iconData: Icons.favorite_outline,
                                      ))
                                  .toList()),
                        ),

                        // Space
                        const SizedBox(height: 20),

                        // Movies feed

                        _movieHeaders(
                          movieTitle: 'Free To Watch',
                          movieType: 'Moives',
                        ),

                        // Space
                        const SizedBox(height: 10),

                        // Free to watch feeds
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: trending.trendingMovies.results
                                  .map((movie) => PopularMovieScreen(
                                      onTap: () {},
                                      movie: movie,
                                      iconData: Icons.favorite_outline))
                                  .toList()),
                        ),
                      ],
                    );
                  } else if (state is MovieFaileToLoadState) {
                    final errorState = state;
                    return Center(
                      child: Text(errorState.errorMessage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Movie headers
  Row _movieHeaders({required String movieTitle, required String movieType}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          movieTitle,
          style: const TextStyle(
            color: MovieAppColor.popularTxtColor,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 3,
          ),
          decoration: BoxDecoration(
              color: MovieAppColor.streamingBgColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Text(
                movieType,
                style: const TextStyle(color: MovieAppColor.popularTxtColor),
              ),
              const SizedBox(width: 5),
              const Image(
                  height: 10,
                  width: 10,
                  image: AssetImage('assets/images/Polygon.png')),
            ],
          ),
        ),
      ],
    );
  }
}
