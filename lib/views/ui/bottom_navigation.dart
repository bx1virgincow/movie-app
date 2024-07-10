import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/views/bloc/bloc/bottom_nav_bloc.dart';
import 'package:movieapp/views/ui/favorite_page.dart';
import 'package:movieapp/views/ui/home_page.dart';
import 'package:movieapp/views/ui/settings_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: _pages[state.tabIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (value) => context.read<BottomNavBloc>().add(
                  OnTabChangedEvent(
                    tabIndex: value,
                  ),
                ),
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

List<Widget> _pages = const <Widget>[
  HomePage(),
  FavoritePage(),
  SettingsPage(),
];
