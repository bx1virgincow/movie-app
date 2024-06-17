import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/ui/landing_screen.dart';
import 'package:movieapp/views/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        MovieRepoImplementation(),
      ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/landing': (context) => const LandingScreen()
          }),
    );
  }
}
