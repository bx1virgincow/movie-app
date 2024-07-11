import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/color.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/ui/details_page.dart';
import 'package:movieapp/views/widgets/search_results_widget.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final _searchQueryStreamController = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchQueryStreamController.add(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQueryStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(MovieRepoImplementation()),
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search for movies, tv show...',
              border: InputBorder.none,
            ),
          ),
          backgroundColor: MovieAppColor.homepageColor,
        ),
        body: StreamBuilder<String>(
          stream: _searchQueryStreamController.stream
              .debounceTime(const Duration(milliseconds: 500)),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              context.read<MovieBloc>().add(
                    SearchMovieEvent(query: snapshot.data!),
                  );
            }

            return BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMovieState) {
                  var movies = state.movieResponse;
                  return ListView.builder(
                    itemCount: state.movieResponse.results.length,
                    itemBuilder: (context, index) {
                      final movie = movies.results[index];
                      return SearchTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(movie: movie),
                            ),
                          );
                        },
                        movie: movie,
                      );
                    },
                  );
                } else if (state is MovieFaileToLoadState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const Center(
                    child: Text('Search for movies, tv show...'),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
