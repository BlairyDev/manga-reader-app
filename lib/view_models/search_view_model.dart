import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  SearchViewModel({required this.repository});

  String _title = "   ";

  String get title => _title;

  set title(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  late final PagingController<int, MangaData> pagingController =
      PagingController(
        getNextPageKey: (state) =>
            state.lastPageIsEmpty ? null : state.nextIntPageKey,
        fetchPage: (pageKey) => loadSearchManga(_title, pageKey),
      );

  Future<List<MangaData>> loadSearchManga(String title, int offset) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return await repository.getSearchManga(title, (offset - 1) * 6);
    } catch (e) {
      throw Exception(e);
    }
  }
}
