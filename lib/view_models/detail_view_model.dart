import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';

class DetailViewModel extends ChangeNotifier {
  final MangadexRepository mangaRepository;
  final DataRepository dataRepository;

  DetailViewModel({
    required this.mangaRepository,
    required this.dataRepository,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _inLibrary = false;
  bool get inLibrary => _inLibrary;

  Map<String, Volume> _mangaChapters = {};
  Map<String, Volume> get mangaChapters => _mangaChapters;

  Future<void> loadMangaChapters(String mangaId) async {
    _isLoading = true;
    try {
      _mangaChapters = await mangaRepository.getMangaChapters(mangaId);

      notifyListeners();
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> insertManga(Manga manga) async {
    dataRepository.insertManga(manga);
    _inLibrary = true;
    notifyListeners();
  }

  Future<void> removeManga(String mangaId) async {
    dataRepository.removeManga(mangaId);
    _inLibrary = false;
    notifyListeners();
  }

  Future<void> checkInLibrary(String mangaId) async {
    try {
      _inLibrary = await dataRepository.checkInLibrary(mangaId);
      notifyListeners();
    } catch (e) {
      _inLibrary = false;
    }
  }
}
