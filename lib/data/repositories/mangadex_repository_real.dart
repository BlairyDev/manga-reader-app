import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/mangadex_repository.dart';
import 'package:manga_reader_app/data/services/mangadex_api_service.dart';

class MangadexRepositoryReal implements MangadexRepository {
  final MangadexApiService _service = MangadexApiService();

  @override
  Future<List<MangaData>> getMangaSeries() async {
    try {
      final result = await _service.fetchMangaSeries();

      print(result);

      final response = MangaResponse.fromJson(result);

      print(response.data);
      for (var manga in response.data) {
        print("ID: ${manga.id}");
        print("Title: ${manga.attributes!.title}");
        print("Description: ${manga.attributes!.title}");
        print("Status: ${manga.attributes!.title}");
        print("---------------------------");
      }

      List<MangaData> mangas = response.data;

      return mangas;
    } catch (e) {
      throw Exception(e);
    }
  }
}
