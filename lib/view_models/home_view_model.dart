import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/mangadex_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  HomeViewModel({required this.repository});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<MangaData> _mangas = [];
  List<MangaData> get mangas => _mangas;

  Future<void> loadMangaSeries() async {
    _isLoading = true;
    try {
      _mangas = await repository.getMangaSeries();
      print("${_mangas[0].attributes!.title} test");
      notifyListeners();
    } catch (e) {
      _mangas = [];
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadSearchManga(String title) async {
    _isLoading = true;
    try {
      _mangas = await repository.getSearchManga(title);
      notifyListeners();
    } catch (e) {
      _mangas = [];
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }
}
