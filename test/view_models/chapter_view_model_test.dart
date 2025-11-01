import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapter_image_list_response.dart';
import 'package:manga_reader_app/data/repositories/manga_repository/mangadex_repository.dart';
import 'package:manga_reader_app/view_models/chapter_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockMangadexRepository extends Mock implements MangadexRepository {}

void main() {
  late MockMangadexRepository mockRepository;
  late ChapterViewModel viewModel;

  setUp(() {
    mockRepository = MockMangadexRepository();
    viewModel = ChapterViewModel(repository: mockRepository);
  });

  group('ChapterViewModel Tests', () {
    const testChapterId = "123";

    final testChapter = Chapter(
      hash: "abcd1234",
      data: ["page1.jpg", "page2.jpg"],
      dataSaver: ["page1_saver.jpg", "page2_saver.jpg"],
    );

    final testResponse = MangaChapterImageList(
      result: "ok",
      baseUrl: "https://uploads.mangadex.org",
      chapter: testChapter,
    );

    test('loadChapterImageList loads data successfully', () async {
      // 2️⃣ Arrange: set up the repository mock
      when(
        () => mockRepository.getChapterImageList(testChapterId),
      ).thenAnswer((_) async => testResponse);

      // 3️⃣ Act: call the method
      await viewModel.loadChapterImageList(testChapterId);

      // 4️⃣ Assert: verify expected behavior
      expect(viewModel.isLoading, false);
      expect(viewModel.chapterImageList, equals(testChapter.data));
      expect(viewModel.hashChapter, equals(testChapter.hash));

      // Verify the repository was called once
      verify(() => mockRepository.getChapterImageList(testChapterId)).called(1);
    });

    test('loadChapterImageList throws exception on failure', () async {
      // Arrange: make repository throw
      when(
        () => mockRepository.getChapterImageList(testChapterId),
      ).thenThrow(Exception("Network error"));

      // Act & Assert
      expect(
        () async => await viewModel.loadChapterImageList(testChapterId),
        throwsA(isA<Exception>()),
      );

      // Ensure _isLoading resets to false
      expect(viewModel.isLoading, false);

      verify(() => mockRepository.getChapterImageList(testChapterId)).called(1);
    });
  });
}
