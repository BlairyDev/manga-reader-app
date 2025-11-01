import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/view_models/search_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockMangadexRepository extends Mock implements MangadexRepository {}

void main() {
  late MockMangadexRepository mockRepository;
  late SearchViewModel viewModel;

  setUp(() {
    mockRepository = MockMangadexRepository();
    viewModel = SearchViewModel(repository: mockRepository);
  });

  test('loadSearchManga returns a list of MangaData', () async {
    final fakeSearchList = [
      MangaData(
        id: '2',
        type: 'manga',
        attributes: MangaAttributes(
          title: Title(en: 'Search Manga'),
          altTitles: [],
          description: PurpleDescription(
            en: 'Search Desc',
            ko: '',
            zh: '',
            zhHk: '',
            de: '',
            es: '',
            fr: '',
            id: '',
            ja: '',
            th: '',
            ptBr: '',
            pl: '',
            ru: '',
            uk: '',
            vi: '',
            pt: '',
            tr: '',
            esLa: '',
          ),
          isLocked: false,
          links: Links(
            al: '',
            ap: '',
            mu: '',
            nu: '',
            mal: '',
            raw: '',
            engtl: '',
            kt: '',
            bw: '',
            amz: '',
            cdj: '',
            ebj: '',
          ),
          officialLinks: null,
          originalLanguage: 'en',
          lastVolume: null,
          lastChapter: null,
          publicationDemographic: null,
          status: 'ongoing',
          year: 2025,
          contentRating: 'safe',
          tags: [],
          state: 'published',
          chapterNumbersResetOnNewVolume: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          version: 1,
          availableTranslatedLanguages: ['en'],
          latestUploadedChapter: null,
        ),
        relationships: [],
      ),
    ];

    when(
      () => mockRepository.getSearchManga('Test', 0),
    ).thenAnswer((_) async => fakeSearchList);

    final result = await viewModel.loadSearchManga('Test', 1);

    expect(result, isA<List<MangaData>>());
    expect(result.length, 1);
    expect(result[0].attributes?.title?.en, 'Search Manga');

    verify(() => mockRepository.getSearchManga('Test', 0)).called(1);
  });
}
