import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/data/movie_repo_impl.dart';
import 'package:movieapp/views/bloc/bloc/bottom_nav_bloc.dart';
import 'package:movieapp/views/bloc/bloc/movie_bloc.dart';
import 'package:movieapp/views/ui/bottom_navigation.dart';
import 'package:movieapp/views/ui/home_page.dart';
import 'package:movieapp/views/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(
            MovieRepoImplementation(),
          ),
        ),
        BlocProvider(create: (context) => BottomNavBloc()),
      ],
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
            '/home': (context) => const HomePage(),
            '/bottomnav': (context) => const BottomNav()
          }),
    );
  }
}
