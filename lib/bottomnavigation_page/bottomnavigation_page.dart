import 'package:flutter/material.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/search/search_page.dart';
import '../page-1/favoritesongs.dart';
import '../page-1/Library.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _pages[_currentIndex],
        BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },

            // to get rid of the shadow
            // currentIndex: NavigationBar._selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[400],
            // onTap: _onItemTapped,
            backgroundColor: Colors.white10,
            elevation: 0,

            //  transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
            type: BottomNavigationBarType.fixed,
            // unselectedItemColor: Colors.grey[400],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_sharp,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music_sharp,
                ),
                label: 'Library',
              ),
            ])
      ],
    );
  }

  final _pages = [HomePage(), SearchPage(), LikedSongsPage(), LibraryPage()];
}
