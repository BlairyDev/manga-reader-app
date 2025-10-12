import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/view/detail_screen.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCarouselMode = true;
  Icon visibleIcon = const Icon(Icons.search, color: Colors.white);
  Widget searchBar = const Text(
    'Manga Reader',
    style: TextStyle(fontFamily: 'Broadway', fontSize: 24, color: Colors.white),
  );

  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).loadMangaSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      ).loadSearchManga(text);

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
                  ).loadMangaSeries();

                  setState(() {
                    _isCarouselMode = true;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          List<MangaData>? mangas = viewModel.mangas;
          int? mangasCount = mangas.length;

          bool isLoading = viewModel.isLoading;

          return Center(
            child: viewModel.isLoading
                ? CircularProgressIndicator()
                : GridView.builder(
                    itemCount: mangasCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                id: mangas[index].id!,
                                title:
                                    mangas[index].attributes!.title?.en
                                        .toString() ??
                                    "",
                                description: mangas[index]
                                    .attributes!
                                    .description!
                                    .en
                                    .toString(),
                              ),
                            ),
                          );
                        },

                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  mangas[index].attributes!.title!.en
                                      .toString(),
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
