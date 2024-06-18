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

<<<<<<< HEAD
class _BottomNavState extends State<BottomNav>
    with AutomaticKeepAliveClientMixin {
=======
class _BottomNavState extends State<BottomNav> with AutomaticKeepAliveClientMixin{
>>>>>>> 240ba677d9b56f95d411aeff7f4458bed6a9ca7f
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
<<<<<<< HEAD
        return SafeArea(
          child: Scaffold(
            body: _currentPages[state.tabIndex],
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
=======
        return Scaffold(
          body: _currentPages[state.tabIndex],
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
>>>>>>> 240ba677d9b56f95d411aeff7f4458bed6a9ca7f
          ),
        );
      },
    );
  }
<<<<<<< HEAD

=======
  
>>>>>>> 240ba677d9b56f95d411aeff7f4458bed6a9ca7f
  @override
  bool get wantKeepAlive => true;
}

List<Widget> _currentPages = const <Widget>[
  HomePage(),
  FavoritePage(),
  SettingsPage(),
];
