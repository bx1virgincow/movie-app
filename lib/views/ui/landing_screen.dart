import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movieapp/common/color.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //welcome text and user
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Hello'),
                    //space
                    const SizedBox(width: 10),
                    Icon(Icons.abc)
                  ],
                ),
                CircleAvatar(
                  child: Icon(Icons.person_outlined),
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
            //space
            const SizedBox(height: 10),

            //search field
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: MovieAppColor.searchIconColor,
                ),
                hintText: 'Search for movies, tv show...',
                hintStyle: TextStyle(
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

            //Text
            _movieHeaders(
              movieTitle: 'Popular Movies',
              movieType: 'Streaming',
            ),

            //movie displays
            movieLists(
              context,
              image: 'https://picsum.photos/200/300',
              iconData: Icons.favorite_outline,
              movieTitle: 'Bird\'s of Prey',
              movieDate: '9/23/16',
            ),
            //space
            const SizedBox(height: 10),
            //movie
            _movieHeaders(
              movieTitle: 'Free to Watch',
              movieType: 'Movie',
            ),

            movieLists(
              context,
              image: 'https://picsum.photos/200/300',
              iconData: Icons.favorite_outline,
              movieTitle: 'Bird\'s of Prey',
              movieDate: '9/23/16',
            ),
          ],
        ),
      )),
    );
  }

  Row movieLists(
    BuildContext context, {
    required String image,
    required IconData iconData,
    required String movieTitle,
    required String movieDate,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: 200,
                    width: MediaQuery.of(context).size.width * .45,
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Failed to load picture'),
                    // loadingBuilder: (context, child, loadingProgress) =>
                    //     const CircularProgressIndicator(),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),
            Text(movieTitle),
            Text(movieDate),
          ],
        ),
      ],
    );
  }

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
                style: TextStyle(color: MovieAppColor.popularTxtColor),
              ),
              SizedBox(width: 5),
              Icon(
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