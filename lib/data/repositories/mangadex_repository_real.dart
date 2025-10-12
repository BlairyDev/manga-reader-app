import 'package:manga_reader_app/data/model/manga/manga_chapter_image_list_response.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/repositories/mangadex_repository.dart';
import 'package:manga_reader_app/data/services/mangadex_api_service.dart';

class MangadexRepositoryReal implements MangadexRepository {
  final MangadexApiService _service = MangadexApiService();

  @override
  Future<List<MangaData>> getMangaSeries() async {
    try {
      final result = await _service.fetchMangaSeries();

      final response = MangaResponse.fromJson(result);

      List<MangaData> mangas = response.data;

      return mangas;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Map<String, Volume>> getMangaChapters(String mangaId) async {
    try {
      final result = await _service.fetchMangaChapters(mangaId);

      final response = MangaChaptersResponse.fromJson(result);

      return response.volumes;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<MangaChapterImageList> getChapterImageList(String chapterId) async {
    try {
      final result = await _service.fetchChapterImageList(chapterId);

      final response = MangaChapterImageList.fromJson(result);

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
