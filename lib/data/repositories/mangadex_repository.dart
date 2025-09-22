import 'package:manga_reader_app/data/model/manga/manga_response.dart';

abstract class MangadexRepository {
  Future<List<MangaData>> getMangaSeries();
}
