import 'package:cached_network_image/cached_network_image.dart';
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
            child: isLoading
                ? CircularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: mangasCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        String? fileName = mangas[index].relationships
                            .firstWhere((r) => r.type == "cover_art")
                            .attributes
                            ?.fileName
                            .toString();

                        final coverArtUrl = fileName != null
                            ? "https://uploads.mangadex.org/covers/${mangas[index].id}/$fileName"
                            : null;

                        List<Relationship> authors = mangas[index].relationships
                            .where((r) => r.type == "author")
                            .toList();

                        List<Relationship> artists = mangas[index].relationships
                            .where((r) => r.type == "artist")
                            .toList();

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  id: mangas[index].id!,
                                  title:
                                      mangas[index].attributes!.title!.en ??
                                      mangas[index].attributes!.title!.jaRo
                                          .toString(),
                                  description: mangas[index]
                                      .attributes!
                                      .description!
                                      .en
                                      .toString(),
                                  status:
                                      mangas[index].attributes!.status ?? "",
                                  authors: authors,
                                  artists: artists,
                                  covertArtUrl: coverArtUrl.toString(),
                                ),
                              ),
                            );
                          },

                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  width: 300,
                                  imageUrl: coverArtUrl.toString(),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                        imageUrl:
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019",
                                      ),
                                ),

                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    child: Text(
                                      mangas[index].attributes!.title!.en ??
                                          mangas[index].attributes!.title!.jaRo
                                              .toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
