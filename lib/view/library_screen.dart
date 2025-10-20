import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/view/detail_screen.dart';
import 'package:manga_reader_app/view_models/library_view_model.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        List<Manga>? mangas = viewModel.mangas;
        int? mangasCount = mangas.length;

        bool isLoading = viewModel.isLoading;

        viewModel.loadMangaSeries();

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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                id: mangas[index].mangaId,
                                title: mangas[index].title,
                                description: mangas[index].description,
                                status: mangas[index].status,
                                authors: mangas[index].authors,
                                artists: mangas[index].artists,
                                coverArtUrl: mangas[index].coverArtUrl,
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
                                imageUrl: mangas[index].coverArtUrl,
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
                                    color: Colors.black.withValues(alpha: 0.3),
                                  ),
                                  child: Text(
                                    mangas[index].title,
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
    );
  }
}
