import 'package:get_it/get_it.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository_real.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository_fake.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository_real.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<MangadexRepository>(() => MangadexRepositoryReal());
  locator.registerFactory<DataRepository>(() => DataRepositoryReal());
}
