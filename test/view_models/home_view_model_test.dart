import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/view_models/home_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockMangadexRepository extends Mock implements MangadexRepository {}

void main() {
  late HomeViewModel viewModel;
  late MockMangadexRepository mockRepository;

  setUp(() {
    mockRepository = MockMangadexRepository();
    viewModel = HomeViewModel(repository: mockRepository);
  });

  // 2️⃣ Sample data
  final sampleMangaData = MangaData(
    id: '1',
    type: 'manga',
    attributes: MangaAttributes(
      title: Title(en: 'Test Manga'),
      altTitles: [],
      description: PurpleDescription(
        en: 'Description',
        ko: null,
        zh: null,
        zhHk: null,
        de: null,
        es: null,
        fr: null,
        id: null,
        ja: null,
        th: null,
        ptBr: null,
        pl: null,
        ru: null,
        uk: null,
        vi: null,
        pt: null,
        tr: null,
        esLa: null,
      ),
      isLocked: false,
      links: Links(
        al: null,
        ap: null,
        mu: null,
        nu: null,
        mal: null,
        raw: null,
        engtl: null,
        kt: null,
        bw: null,
        amz: null,
        cdj: null,
        ebj: null,
      ),
      officialLinks: null,
      originalLanguage: 'en',
      lastVolume: '1',
      lastChapter: '1',
      publicationDemographic: 'shounen',
      status: 'ongoing',
      year: 2024,
      contentRating: 'safe',
      tags: [],
      state: 'published',
      chapterNumbersResetOnNewVolume: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
      availableTranslatedLanguages: ['en'],
      latestUploadedChapter: '1',
    ),
    relationships: [],
  );

  final sampleResponse = MangaResponse(
    result: 'ok',
    response: 'success',
    data: [sampleMangaData],
    limit: 6,
    offset: 0,
    total: 1,
  );

  // 3️⃣ Test: Successful fetch
  test('returns list of MangaData when repository succeeds', () async {
    when(
      () => mockRepository.getMangaSeries(0),
    ).thenAnswer((_) async => sampleResponse.data);

    final result = await viewModel.loadMangaSeries(1);

    expect(result, isA<List<MangaData>>());
    expect(result.length, 1);
    expect(result.first.id, '1');
    expect(result.first.attributes?.title?.en, 'Test Manga');
  });

  // 4️⃣ Test: Empty list
  test('returns empty list when repository returns empty', () async {
    final emptyResponse = MangaResponse(
      result: 'ok',
      response: 'success',
      data: [],
      limit: 6,
      offset: 0,
      total: 0,
    );

    when(
      () => mockRepository.getMangaSeries(0),
    ).thenAnswer((_) async => emptyResponse.data);

    final result = await viewModel.loadMangaSeries(1);

    expect(result, isEmpty);
  });

  // 5️⃣ Test: Throws exception
  test('throws exception when repository fails', () async {
    when(
      () => mockRepository.getMangaSeries(0),
    ).thenThrow(Exception('Network error'));

    expect(() async => await viewModel.loadMangaSeries(1), throwsException);
  });
}
