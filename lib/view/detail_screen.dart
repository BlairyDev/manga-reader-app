import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/routes/routes_animations.dart';
import 'package:manga_reader_app/view/chapter_screen.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.authors,
    required this.artists,
    required this.tags,
    required this.coverArtUrl,
  });

  final String id;
  final String title;
  final String description;
  final String status;
  final List<String> authors;
  final List<String> artists;
  final List<String> tags;
  final String coverArtUrl;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Provider.of<DetailViewModel>(
      context,
      listen: false,
    ).checkInLibrary(widget.id);

    Provider.of<DetailViewModel>(
      context,
      listen: false,
    ).loadMangaChapters(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authorNames = widget.authors.join(", ");

    final artistNames = widget.artists.join(", ");

    return Scaffold(
      appBar: AppBar(title: Text(""), forceMaterialTransparency: true),
      body: Consumer<DetailViewModel>(
        builder: (context, viewModel, child) {
          Map<String, Volume> mangaVolumes = viewModel.mangaChapters;

          bool isFavorite = viewModel.inLibrary;

          return viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      width: 150,
                                      height: 225,
                                      fit: BoxFit.cover,
                                      imageUrl: widget.coverArtUrl,
                                      placeholder: (context, url) => Center(
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
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
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          List<String> authors = authorNames
                                              .split(', ')
                                              .map((s) => s.trim())
                                              .toList();
                                          List<String> artists = artistNames
                                              .split(', ')
                                              .map((s) => s.trim())
                                              .toList();

                                          if (isFavorite) {
                                            viewModel.removeManga(widget.id);
                                          } else {
                                            viewModel.insertManga(
                                              Manga(
                                                mangaId: widget.id,
                                                title: widget.title,
                                                description: widget.description,
                                                authors: authors,
                                                artists: artists,
                                                coverArtUrl: widget.coverArtUrl,
                                                tags: widget.tags,
                                                status: widget.status,
                                              ),
                                            );
                                          }
                                        },
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        isFavorite
                                            ? "In Library"
                                            : "Add to Library",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height: 280,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            ExpandableText(
                                              widget.description,
                                              expandText: "Show More",
                                              collapseText: "Show Less",
                                              maxLines: 3,
                                              linkColor: Colors.blue,
                                            ),
                                            SizedBox(height: 12),
                                            Text(
                                              "Status: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(widget.status.capitalize()),

                                            SizedBox(height: 8),
                                            Text(
                                              "Authors: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(authorNames),
                                            SizedBox(height: 8),
                                            Text(
                                              "Artists: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(artistNames),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 7.0,
                            children: widget.tags.map((String tag) {
                              return Chip(
                                label: Text(
                                  tag,
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        viewModel.isChapterEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      'No chapters available',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: mangaVolumes.length,
                                  itemBuilder: (context, index) {
                                    Map<String, Chapter> chapters =
                                        mangaVolumes[mangaVolumes.keys
                                                .elementAt(index)]!
                                            .chapters;

                                    return ExpansionTile(
                                      title: Text(
                                        "Volume ${mangaVolumes.length - index}",
                                      ),
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: chapters.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  slideFromRightRoute(
                                                    ChapterScreen(
                                                      chapterIndex: index,
                                                      chapters: chapters,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  chapters[chapters.keys
                                                          .elementAt(index)]!
                                                      .chapter
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
