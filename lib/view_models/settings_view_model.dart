import 'package:flutter/material.dart';
import 'package:manga_reader_app/data/repositories/data_repository/data_repository.dart';

class SettingsViewModel extends ChangeNotifier {
  final DataRepository dataRepository;

  SettingsViewModel({required this.dataRepository});

  String _message = "";
  String get message => _message;

  Future<void> exportDatabase() async {
    try {
      bool result = await dataRepository.getExportDatabase();
      if (result) {
        _message = "File saved successfully";
        notifyListeners();
      }
    } catch (e) {
      _message =
          "File not saved. You might not have a library or there was an error.";
      notifyListeners();
    }
  }

  Future<void> importDatabase() async {
    try {
      bool result = await dataRepository.getImportDatabase();
      if (result) {
        _message = "Library restored successfully";
        notifyListeners();
      }
    } catch (e) {
      _message =
          "Library not restored. You might not have a library or there was an error.";
    }
  }

  void clearMessage() {
    _message = '';
  }
}
