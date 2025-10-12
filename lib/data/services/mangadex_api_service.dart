import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MangadexApiService {
  Future<Map<String, dynamic>> runAPI(API) async {
    http.Response result = await http.get(Uri.parse(API));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);

      return jsonResponse;
    } else {
      throw Exception("Failed to fetch");
    }
  }

  Future<Map<String, dynamic>> fetchMangaSeries() async {
    final String upcomingAPI =
        "https://api.mangadex.org/manga?limit=10&includedTagsMode=AND&excludedTagsMode=OR&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=cover_art";

    return runAPI(upcomingAPI);
  }

  Future<Map<String, dynamic>> fetchMangaChapters(String mangaId) async {
    final String upcomingAPI =
        "https://api.mangadex.org/manga/$mangaId/aggregate?translatedLanguage%5B%5D=en";

    return runAPI(upcomingAPI);
  }

  Future<Map<String, dynamic>> fetchChapterImageList(String chapterId) async {
    final String upcomingAPI =
        "https://api.mangadex.org/at-home/server/$chapterId";

    return runAPI(upcomingAPI);
  }

  Future<Map<String, dynamic>> fetchSearchManga(String title) async {
    String text = title.replaceAll(' ', '%');

    final String upcomingAPI =
        "https://api.mangadex.org/manga?limit=10&title=${text}&includedTagsMode=AND&excludedTagsMode=OR&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=cover_art";

    return runAPI(upcomingAPI);
  }
}
