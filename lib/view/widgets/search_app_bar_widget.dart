import 'package:flutter/material.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:manga_reader_app/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBarWidget({super.key});

  @override
  State<SearchAppBarWidget> createState() => _SearchAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  bool _isCarouselMode = true;
  Icon visibleIcon = const Icon(Icons.search, color: Colors.white);
  Widget searchBar = const Text(
    'Search Manga',
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
                    Provider.of<SearchViewModel>(context, listen: false).title =
                        text;

                    Provider.of<SearchViewModel>(
                      context,
                      listen: false,
                    ).pagingController.refresh();

                    setState(() {
                      _isCarouselMode = false;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  decoration: const InputDecoration(
                    hintText: 'Search series...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                );
              } else {
                visibleIcon = const Icon(Icons.search, color: Colors.white);
                searchBar = const Text(
                  'Search',
                  style: TextStyle(fontFamily: 'Broadway', fontSize: 24),
                );
                Provider.of<SearchViewModel>(
                  context,
                  listen: false,
                ).loadSearchManga("", 0);

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
