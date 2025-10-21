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
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).loadMangaSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
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

                      final authorNames = authors
                          .where((r) => r.type == "author")
                          .map((r) => r.attributes?.name ?? "")
                          .toList();

                      final artistNames = artists
                          .where((r) => r.type == "artist")
                          .map((r) => r.attributes?.name ?? "")
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
                                status: mangas[index].attributes!.status ?? "",
                                authors: authorNames,
                                artists: artistNames,
                                coverArtUrl: coverArtUrl.toString(),
                              ),
                            ),
                          );
                        },

                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              SizedBox.expand(
                                child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: CachedNetworkImage(
                                    width: 300,
                                    imageUrl: coverArtUrl.toString(),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        CachedNetworkImage(
                                          imageUrl:
                                              "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/330px-No-Image-Placeholder.svg.png?20200912122019",
                                        ),
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.3),
                                  ),
                                  child: Text(
                                    mangas[index].attributes!.title!.en ??
                                        mangas[index].attributes!.title!.jaRo ??
                                        mangas[index].attributes!.title!.ja
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
    );
  }
}
