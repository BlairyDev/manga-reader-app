import 'package:manga_reader_app/data/model/manga/manga_chapter_image_list_response.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';

abstract class MangadexRepository {
  Future<List<MangaData>> getMangaSeries();
  Future<Map<String, Volume>> getMangaChapters(String mangaId);
  Future<MangaChapterImageList> getChapterImageList(String chapterId);
  Future<List<MangaData>> getSearchManga(String title);
}
