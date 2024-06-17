import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/widgets/popular_movies_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  //bloc initialization
  final MovieBloc _movieBloc = MovieBloc(MovieRepoImplementation());

  //call onload method on initState
  @override
  void initState() {
    super.initState();
    _movieBloc.add(OnPopularMovieLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //welcome text and user
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text('Hello'),
                      //space
                      SizedBox(width: 10),
                      Icon(Icons.abc)
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      MovieRepoImplementation().getPopularMovies();
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.person_outlined),
                    ),
                  )
                ],
              ),

              //bold text
              const SizedBox(height: 10),

              //text
              Text(
                'Millions of movies, TV shows to explore now.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              //search bar
              //space
              const SizedBox(height: 10),

              //search field
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: MovieAppColor.searchIconColor,
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

              //space
              const SizedBox(height: 20),

              _movieHeaders(movieTitle: 'Popular', movieType: 'Streaming'),
              const SizedBox(height: 10),

              BlocBuilder<MovieBloc, MovieState>(
                bloc: _movieBloc,
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesState) {
                    var successState = state;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: successState.popularMovies.results
                              .map((movie) => PopularMovieScreen(
                                  movieBloc: _movieBloc,
                                  movie: movie,
                                  iconData: Icons.favorite_outline))
                              .toList()),
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

  //movie headers
  Row _movieHeaders({required String movieTitle, required String movieType}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          movieTitle,
          style: const TextStyle(color: MovieAppColor.popularTxtColor),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 2,
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
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.red,
              )
            ],
          ),
        ),
      ],
    );
  }
}


// Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await MovieRepoImplementation().getMovies();
//           },
//           child: const Text('Fetch Data'),
//         ),
//       ),