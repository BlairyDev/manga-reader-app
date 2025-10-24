import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  HomeViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MangaData> _mangas = [];
  List<MangaData> get mangas => _mangas;

  late final PagingController<int, MangaData> pagingController =
      PagingController(
        getNextPageKey: (state) =>
            state.lastPageIsEmpty ? null : state.nextIntPageKey,
        fetchPage: (pageKey) => loadMangaSeries(pageKey),
      );

  Future<List<MangaData>> loadMangaSeries(int offset) async {
    _isLoading = false;
    try {
      print((offset - 1).toString() + " offset");
      final items = await repository.getMangaSeries((offset - 1) * 6);
      return items;
    } catch (e) {
      _mangas = [];
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadSearchManga(String title, int offset) async {
    _isLoading = true;
    try {
      _mangas = await repository.getSearchManga(title, offset);
      notifyListeners();
    } catch (e) {
      _mangas = [];
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }
}
