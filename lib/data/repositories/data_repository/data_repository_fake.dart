import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';

class DataRepositoryFake implements DataRepository {
  @override
  Future<List<Manga>> getMangaSeries() {
    // TODO: implement getMangaSeries
    throw UnimplementedError();
  }

  @override
  Future<void> insertManga(Manga manga) {
    // TODO: implement insertManga
    throw UnimplementedError();
  }

  @override
  Future<void> removeManga(String mangaId) {
    // TODO: implement removeManga
    throw UnimplementedError();
  }

  @override
  Future<bool> checkInLibrary(String mangaId) {
    // TODO: implement checkInLibrary
    throw UnimplementedError();
  }

  @override
  Future<bool> getExportDatabase() {
    // TODO: implement fetchExportDatabase
    throw UnimplementedError();
  }

  @override
  Future<bool> getImportDatabase() {
    // TODO: implement fetchImportDatabase
    throw UnimplementedError();
  }
}
