import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final MangadexRepository repository;

  HomeViewModel({required this.repository});

  late final PagingController<int, MangaData> pagingController =
      PagingController(
        getNextPageKey: (state) =>
            state.lastPageIsEmpty ? null : state.nextIntPageKey,
        fetchPage: (pageKey) => loadMangaSeries(pageKey),
      );

  Future<List<MangaData>> loadMangaSeries(int offset) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      final items = await repository.getMangaSeries((offset - 1) * 6);
      return items;
    } catch (e) {
      throw Exception(e);
    }
  }
}
