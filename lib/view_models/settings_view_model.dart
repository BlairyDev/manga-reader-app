import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final DataRepository dataRepository;

  SettingsViewModel({required this.dataRepository});

  bool _save = true;
  bool get save => _save;

  Future<void> exportDatabase() async {
    try {
      bool result = await dataRepository.getExportDatabase();
      _save = result;
    } catch (e) {
      _save = false;
    }
    notifyListeners();
  }
}
