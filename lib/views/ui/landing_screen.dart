import 'package:flutter/material.dart';
import 'package:movieapp/data/movie_repo_impl.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await MovieRepoImplementation().getMovies();
          },
          child: const Text('Fetch Data'),
        ),
      ),
    );
  }
}
