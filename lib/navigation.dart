import 'package:flutter/material.dart';
import 'package:manga_reader_app/view/home_screen.dart';
import 'package:manga_reader_app/view/library_screen.dart';
import 'package:manga_reader_app/view/search_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), LibraryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 45, 119, 230),
              title: Text(
                "Manga Reader App",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  ),
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            )
          : AppBar(
              backgroundColor: const Color.fromARGB(255, 45, 119, 230),
              title: Text("Library", style: TextStyle(color: Colors.white)),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Library"),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
      body: _pages[_currentIndex],
    );
  }
}
