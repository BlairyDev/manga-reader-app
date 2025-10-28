import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/services/database_service.dart';

class DataRepositoryReal implements DataRepository {
  @override
  Future<List<Manga>> getMangaSeries() async {
    final mangaMaps = await DatabaseService.instance.queryAllMangas();
    return mangaMaps.map((manga) => Manga.fromMap(manga)).toList();
  }

  @override
  Future<void> insertManga(Manga manga) async {
    await DatabaseService.instance.insertManga(manga);
  }

  @override
  Future<void> removeManga(String mangaId) async {
    await DatabaseService.instance.removeManga(mangaId);
  }

  @override
  Future<bool> checkInLibrary(String mangaId) async {
    bool inLibrary = await DatabaseService.instance.checkInLibrary(mangaId);
    return inLibrary;
  }

  @override
  Future<bool> getExportDatabase() async {
    final result = await DatabaseService.instance.exportDatabase();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> getImportDatabase() async {
    final result = await DatabaseService.instance.importDatabase();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
