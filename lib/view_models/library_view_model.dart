import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';

class LibraryViewModel extends ChangeNotifier {
  final DataRepository dataRepository;

  LibraryViewModel({required this.dataRepository});

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Manga> _mangas = [];
  List<Manga> get mangas => _mangas;

  Future<void> loadMangaSeries() async {
    _isLoading = true;
    try {
      _mangas = await dataRepository.getMangaSeries();
      notifyListeners();
    } catch (e) {
      _mangas = [];
    } finally {
      _isLoading = false;
    }
  }
}
