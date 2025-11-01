import 'package:flutter/material.dart';
import 'package:manga_reader_app/view/home_screen.dart';
import 'package:manga_reader_app/view/library_screen.dart';
import 'package:manga_reader_app/view/search_screen.dart';
import 'package:manga_reader_app/view/settings_screen.dart';
import 'package:manga_reader_app/view/widgets/top_app_bar_widget.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), LibraryScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? TopAppBarWidget(
              title: "MangaStack",
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  ),
                  icon: const Icon(Icons.search),
                ),
              ],
            )
          : _currentIndex == 1
          ? TopAppBarWidget(title: "Library")
          : TopAppBarWidget(title: "Settings"),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Library"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
      body: _pages[_currentIndex],
    );
  }
}
