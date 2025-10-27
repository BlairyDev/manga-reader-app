import 'package:manga_reader_app/data/model/database/manga.dart';

abstract class DataRepository {
  Future<List<Manga>> getMangaSeries();
  Future<void> insertManga(Manga manga);
  Future<void> removeManga(String mangaId);
  Future<bool> checkInLibrary(String mangaId);
  Future<bool> getExportDatabase();
  Future<bool> getImportDatabase();
}
