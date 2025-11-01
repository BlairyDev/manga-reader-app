import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';
import 'package:manga_reader_app/view_models/settings_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  late MockDataRepository mockDataRepository;
  late SettingsViewModel viewModel;

  setUp(() {
    mockDataRepository = MockDataRepository();
    viewModel = SettingsViewModel(dataRepository: mockDataRepository);
  });

  group('SettingsViewModel Tests', () {
    test(
      'exportDatabase sets success message when repository returns true',
      () async {
        // Arrange
        when(
          () => mockDataRepository.getExportDatabase(),
        ).thenAnswer((_) async => true);

        bool notified = false;
        viewModel.addListener(() => notified = true);

        // Act
        await viewModel.exportDatabase();

        // Assert
        expect(viewModel.message, equals("File saved successfully"));
        expect(notified, true);
        verify(() => mockDataRepository.getExportDatabase()).called(1);
      },
    );

    test('exportDatabase sets failure message on exception', () async {
      // Arrange
      when(
        () => mockDataRepository.getExportDatabase(),
      ).thenThrow(Exception("Disk full"));

      bool notified = false;
      viewModel.addListener(() => notified = true);

      // Act
      await viewModel.exportDatabase();

      // Assert
      expect(
        viewModel.message,
        equals(
          "File not saved. You might not have a library or there was an error.",
        ),
      );
      expect(notified, true);
      verify(() => mockDataRepository.getExportDatabase()).called(1);
    });

    test(
      'importDatabase sets success message when repository returns true',
      () async {
        // Arrange
        when(
          () => mockDataRepository.getImportDatabase(),
        ).thenAnswer((_) async => true);

        bool notified = false;
        viewModel.addListener(() => notified = true);

        // Act
        await viewModel.importDatabase();

        // Assert
        expect(viewModel.message, equals("Library restored successfully"));
        expect(notified, true);
        verify(() => mockDataRepository.getImportDatabase()).called(1);
      },
    );

    test('importDatabase sets failure message on exception', () async {
      // Arrange
      when(
        () => mockDataRepository.getImportDatabase(),
      ).thenThrow(Exception("Corrupted file"));

      bool notified = false;
      viewModel.addListener(() => notified = true);

      // Act
      await viewModel.importDatabase();

      // Assert
      expect(
        viewModel.message,
        equals(
          "Library not restored. You might not have a library or there was an error.",
        ),
      );
      // ❗ No notifyListeners() call inside catch block, so listener should NOT be notified
      expect(notified, false);
      verify(() => mockDataRepository.getImportDatabase()).called(1);
    });
  });
}
