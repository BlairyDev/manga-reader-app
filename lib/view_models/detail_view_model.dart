import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/repositories/mangadex_repository.dart';

class DetailViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  DetailViewModel({required this.repository});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Map<String, Volume> _mangaChapters = {};
  Map<String, Volume> get mangaChapters => _mangaChapters;

  Future<void> loadMangaChapters(String mangaId) async {
    _isLoading = true;
    try {
      _mangaChapters = await repository.getMangaChapters(mangaId);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }
}
