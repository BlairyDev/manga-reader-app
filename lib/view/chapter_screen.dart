import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/constants.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/view/routes/routes_animations.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:provider/provider.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    super.key,
    required this.chapterIndex,
    required this.chapters,
  });

  final int chapterIndex;
  final Map<String, Chapter> chapters;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final PageController _pageController = PageController();
  final int preloadThreshold = 1;
  String? hashChapter;
  bool isHorizontal = true;
  bool _showAppBar = true;

  @override
  void initState() {
    Provider.of<ChapterViewModel>(context, listen: false).loadChapterImageList(
      widget.chapters[widget.chapters.keys.elementAt(widget.chapterIndex)]!.id
          .toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(
              title: Text(
                "Chapter ${widget.chapters.length - widget.chapterIndex}",
              ),
              backgroundColor: isDarkModeNotifier.value
                  ? Constants.darkThemedNavBar
                  : Constants.lightThemedNavBar,
            )
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
      bottomNavigationBar: _showAppBar
          ? BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Transform.rotate(
                          angle: 3.14159,
                          child: Icon(Icons.play_arrow, size: 30),
                        ),
                        onPressed:
                            widget.chapterIndex < widget.chapters.length - 1
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  noTransitionRoute(
                                    ChapterScreen(
                                      chapterIndex: widget.chapterIndex + 1,
                                      chapters: widget.chapters,
                                    ),
                                  ),
                                );
                              }
                            : null,
                      ),
                      IconButton(
                        onPressed: widget.chapterIndex > 0
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  noTransitionRoute(
                                    ChapterScreen(
                                      chapterIndex:
                                          widget.chapterIndex <
                                              widget.chapters.length
                                          ? widget.chapterIndex - 1
                                          : widget.chapters.length,
                                      chapters: widget.chapters,
                                    ),
                                  ),
                                );
                              }
                            : null,
                        icon: Icon(Icons.play_arrow, size: 30),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isHorizontal = !isHorizontal;
                      });
                    },
                    icon: isHorizontal
                        ? Icon(Icons.swap_horiz, size: 30)
                        : Icon(Icons.swap_vert, size: 30),
                  ),
                ],
              ),
            )
          : BottomAppBar(color: Colors.transparent),
      body: Consumer<ChapterViewModel>(
        builder: (context, viewModel, child) {
          List<String> chapterImageList = viewModel.chapterImageList;
          int imageCount = chapterImageList.length;
          bool isLoading = viewModel.isLoading;
          String hashChapter = viewModel.hashChapter;

          return !viewModel.isLoading
              ? isHorizontal
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _showAppBar = !_showAppBar;
                          });
                        },
                        child: PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageCount,
                          itemBuilder: (context, index) {
                            if (index + 1 < imageCount) {
                              precacheImage(
                                NetworkImage(
                                  "https://uploads.mangadex.org/data/${hashChapter}/${chapterImageList[index + 1]}",
                                ),
                                context,
                              );
                            }
                            return InteractiveViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://uploads.mangadex.org/data/${hashChapter}/${chapterImageList[index]}",
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            );
                          },
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _showAppBar = !_showAppBar;
                          });
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: imageCount,
                          itemBuilder: (context, index) {
                            for (int i = 1; i <= preloadThreshold; i++) {
                              if (index + i < imageCount) {
                                precacheImage(
                                  NetworkImage(chapterImageList[index + i]),
                                  context,
                                );
                              }
                            }
                            return InteractiveViewer(
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://uploads.mangadex.org/data/${hashChapter}/${chapterImageList[index]}",
                                placeholder: (context, url) => SizedBox(
                                  width: double.infinity,
                                  height: 300,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 500,
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              ),
                            );
                          },
                        ),
                      )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
