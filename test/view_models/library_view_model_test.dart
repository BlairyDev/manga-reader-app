import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/view_models/library_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  late MockDataRepository mockRepository;
  late LibraryViewModel viewModel;

  setUp(() {
    mockRepository = MockDataRepository();
    viewModel = LibraryViewModel(dataRepository: mockRepository);
  });

  final testManga = Manga(
    mangaId: 'manga_001',
    title: 'Test Manga',
    description: 'Description',
    authors: ['Author1'],
    artists: ['Artist1'],
    tags: ['Action'],
    coverArtUrl: 'url',
    status: 'Ongoing',
  );

  test('loadMangaSeries updates mangas list on success', () async {
    when(
      () => mockRepository.getMangaSeries(),
    ).thenAnswer((_) async => [testManga]);

    await viewModel.loadMangaSeries();

    expect(viewModel.mangas, [testManga]);
    expect(viewModel.isLoading, false);
  });

  test('loadMangaSeries sets mangas to empty on failure', () async {
    when(() => mockRepository.getMangaSeries()).thenThrow(Exception('Error'));

    await viewModel.loadMangaSeries();

    expect(viewModel.mangas, []);
    expect(viewModel.isLoading, false);
  });
}
