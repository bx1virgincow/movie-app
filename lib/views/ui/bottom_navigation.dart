import 'package:flutter/material.dart';
import 'package:movieapp/views/ui/favorite_page.dart';
import 'package:movieapp/views/ui/home_page.dart';
import 'package:movieapp/views/ui/settings_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}


List<Widget> currentPages = const <Widget>[
  HomePage(),
  FavoritePage(),
  SettingsPage(),
];