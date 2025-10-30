import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapter_image_list_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';

class ChapterViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  ChapterViewModel({required this.repository});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<String> _chapterImageList = [];
  List<String> get chapterImageList => _chapterImageList;

  String _hashChapter = "";
  String get hashChapter => _hashChapter;

  Future<void> loadChapterImageList(String chapterId) async {
    _isLoading = true;
    try {
      MangaChapterImageList result = await repository.getChapterImageList(
        chapterId,
      );

      _chapterImageList = result.chapter?.data ?? [];
      _hashChapter = result.chapter?.hash ?? "";

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }
}
