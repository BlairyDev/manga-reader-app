import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final PagingController<int, MangaData> pagingController =
        Provider.of<HomeViewModel>(context, listen: false).pagingController;

    return RefreshIndicator(
      onRefresh: () => Future.sync(() => pagingController.refresh()),
      child: PagingListener(
        controller: pagingController,
        builder: (context, state, fetchNextPage) => PagedGridView<int, MangaData>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            invisibleItemsThreshold: 0,
            itemBuilder: (context, item, index) {
              String? fileName = item.relationships
                  .firstWhere((r) => r.type == "cover_art")
                  .attributes
                  ?.fileName
                  .toString();

              final coverArtUrl = fileName != null
                  ? "https://uploads.mangadex.org/covers/${item.id}/$fileName"
                  : null;

              List<Relationship> authors = item.relationships
                  .where((r) => r.type == "author")
                  .toList();

              List<Relationship> artists = item.relationships
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

              final tags = item.attributes?.tags ?? [];

              List<String> combineTags = tags
                  .map(
                    (tag) =>
                        tag.attributes?.name?.en ??
                        tag.attributes?.name?.jaRo ??
                        tag.attributes?.name?.ja ??
                        tag.attributes?.name?.zh ??
                        tag.attributes?.name?.zhHk ??
                        tag.attributes?.name?.ptBr ??
                        tag.attributes?.name?.es ??
                        tag.attributes?.name?.esLa ??
                        tag.attributes?.name?.koRo ??
                        tag.attributes?.name?.zhRo,
                  )
                  .whereType<String>()
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: item.id!,
                        title:
                            item.attributes!.title!.en ??
                            item.attributes!.title!.jaRo ??
                            item.attributes!.title!.ja ??
                            item.attributes!.title!.zh ??
                            item.attributes!.title!.zhHk ??
                            item.attributes!.title!.ptBr ??
                            item.attributes!.title!.es ??
                            item.attributes!.title!.esLa ??
                            item.attributes!.title!.koRo ??
                            item.attributes!.title!.zhRo.toString(),
                        description: item.attributes!.description!.en
                            .toString(),
                        status: item.attributes!.status ?? "",
                        authors: authorNames,
                        artists: artistNames,
                        tags: combineTags,
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
                            item.attributes!.title!.en ??
                                item.attributes!.title!.jaRo ??
                                item.attributes!.title!.ja ??
                                item.attributes!.title!.zh ??
                                item.attributes!.title!.zhHk ??
                                item.attributes!.title!.ptBr ??
                                item.attributes!.title!.es ??
                                item.attributes!.title!.esLa ??
                                item.attributes!.title!.koRo ??
                                item.attributes!.title!.zhRo.toString(),
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 100 / 150,
          ),
          showNewPageErrorIndicatorAsGridChild: false,
          showNewPageProgressIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
        ),
      ),
    );
  }
}
