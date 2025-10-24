import 'package:flutter/material.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  bool _isCarouselMode = true;
  Icon visibleIcon = const Icon(Icons.search, color: Colors.white);
  Widget searchBar = const Text(
    'Manga Reader',
    style: TextStyle(fontFamily: 'Broadway', fontSize: 24, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 45, 119, 230),
      title: searchBar,
      actions: <Widget>[
        IconButton(
          icon: visibleIcon,
          onPressed: () {
            setState(() {
              if (visibleIcon.icon == Icons.search) {
                visibleIcon = const Icon(Icons.cancel, color: Colors.white);
                searchBar = TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String text) {
                    Provider.of<HomeViewModel>(
                      context,
                      listen: false,
                    ).loadSearchManga(text, 0);

                    setState(() {
                      _isCarouselMode = false;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: const InputDecoration(
                    hintText: 'Search movies...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                );
              } else {
                visibleIcon = const Icon(Icons.search, color: Colors.white);
                searchBar = const Text(
                  'Movies',
                  style: TextStyle(fontFamily: 'Broadway', fontSize: 24),
                );
                Provider.of<HomeViewModel>(
                  context,
                  listen: false,
                ).loadMangaSeries(0);

                setState(() {
                  _isCarouselMode = true;
                });
              }
            });
          },
        ),
      ],
    );
  }
}
