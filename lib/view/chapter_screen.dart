import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:provider/provider.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key, required this.chapterId});

  final String chapterId;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  final PageController _pageController = PageController();
  String? hashChapter;
  @override
  void initState() {
    Provider.of<ChapterViewModel>(
      context,
      listen: false,
    ).loadChapterImageList(widget.chapterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chapter Screen")),
      body: Consumer<ChapterViewModel>(
        builder: (context, viewModel, child) {
          List<String> chapterImageList = viewModel.chapterImageList;
          int imageCount = chapterImageList.length;
          bool isLoading = viewModel.isLoading;
          String hashChapter = viewModel.hashChapter;

          return PageView.builder(
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
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
