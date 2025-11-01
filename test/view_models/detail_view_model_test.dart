import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/view_models/detail_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDataRepository extends Mock implements DataRepository {}

class MockMangadexRepository extends Mock implements MangadexRepository {}

void main() {
  late DetailViewModel viewModel;
  late MockMangadexRepository mockMangaRepo;
  late MockDataRepository mockDataRepo;

  setUp(() {
    mockMangaRepo = MockMangadexRepository();
    mockDataRepo = MockDataRepository();

    viewModel = DetailViewModel(
      mangaRepository: mockMangaRepo,
      dataRepository: mockDataRepo,
    );
  });

  group('DetailViewModel Tests', () {
    final testManga = Manga(
      mangaId: 'manga_001',
      title: 'Test Manga',
      description: 'Description',
      authors: ['Author'],
      artists: ['Artist'],
      tags: ['Action'],
      coverArtUrl: 'url',
      status: 'Ongoing',
    );

    final testChaptersResponse = MangaChaptersResponse(
      result: 'ok',
      volumes: {
        '1': Volume(
          volume: '1',
          count: 1,
          chapters: {
            '1': Chapter(
              chapter: '1',
              id: 'c1',
              isUnavailable: false,
              others: [],
              count: 1,
            ),
          },
        ),
      },
    );

    test('loadMangaChapters sets chapters correctly', () async {
      when(
        () => mockMangaRepo.getMangaChapters('manga_001'),
      ).thenAnswer((_) async => testChaptersResponse.volumes);

      await viewModel.loadMangaChapters('manga_001');

      expect(viewModel.isLoading, false);
      expect(viewModel.isChapterEmpty, false);
      expect(viewModel.mangaChapters.length, 1);
      expect(viewModel.mangaChapters['1']!.volume, '1');
    });

    test('insertManga sets inLibrary to true', () async {
      when(
        () => mockDataRepo.insertManga(testManga),
      ).thenAnswer((_) async => {});

      await viewModel.insertManga(testManga);

      expect(viewModel.inLibrary, true);
      verify(() => mockDataRepo.insertManga(testManga)).called(1);
    });

    test('removeManga sets inLibrary to false', () async {
      when(
        () => mockDataRepo.removeManga('manga_001'),
      ).thenAnswer((_) async => {});

      await viewModel.removeManga('manga_001');

      expect(viewModel.inLibrary, false);
      verify(() => mockDataRepo.removeManga('manga_001')).called(1);
    });

    test('checkInLibrary sets inLibrary correctly', () async {
      when(
        () => mockDataRepo.checkInLibrary('manga_001'),
      ).thenAnswer((_) async => true);

      await viewModel.checkInLibrary('manga_001');

      expect(viewModel.inLibrary, true);
      verify(() => mockDataRepo.checkInLibrary('manga_001')).called(1);
    });

    test('checkInLibrary handles error', () async {
      when(
        () => mockDataRepo.checkInLibrary('manga_001'),
      ).thenThrow(Exception('DB Error'));

      await viewModel.checkInLibrary('manga_001');

      expect(viewModel.inLibrary, false);
    });
  });
}
