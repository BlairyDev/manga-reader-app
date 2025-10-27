import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:downloadsfolder/downloadsfolder.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();
  static Database? _database;

  DatabaseService._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'mangareader.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE manga (
        id INTEGER PRIMARY KEY,
        mangaId TEXT,
        title TEXT,
        description TEXT,
        authors TEXT,
        artists TEXT,
        tags TEXT,
        coverArtUrl TEXT,
        status TEXT
      )
    ''');
  }

  Future<int> insertManga(Manga manga) async {
    Database db = await instance.db;
    return await db.insert('manga', manga.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllMangas() async {
    Database db = await instance.db;
    return await db.query('manga');
  }

  Future<bool> checkInLibrary(String mangaId) async {
    final db = await instance.db;
    final results = await db.query(
      'manga',
      where: 'mangaId = ?',
      whereArgs: [mangaId],
    );

    if (results.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<int> removeManga(String mangaId) async {
    Database db = await instance.db;
    return await db.delete('manga', where: 'mangaId = ?', whereArgs: [mangaId]);
  }

  Future<bool> exportDatabase() async {
    try {
      Database db = await instance.db;

      final result = await db.query('manga');
      if (result.isEmpty) return false;

      String jsonData = jsonEncode(result);

      Directory downloadsDir = await getDownloadDirectory();

      String filePath = join(downloadsDir.path, 'manga_export.json');

      int counter = 1;
      while (await File(filePath).exists()) {
        String nameOnly = basenameWithoutExtension('manga_export.text');
        String ext = extension('manga_export.text');
        filePath = join(downloadsDir.path, '$nameOnly($counter)$ext');
        counter++;
      }
      await File(filePath).writeAsString(jsonData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getDatabasePath(String databaseName) async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, databaseName);
  }

  Future<void> importDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db'],
    );

    if (result == null) return;
    File importedFile = File(result.files.single.path!);

    Database importedDb = await openDatabase(importedFile.path);

    List<Map<String, dynamic>> importedMangas = await importedDb.query('manga');

    Database currentDb = await instance.db;

    for (var mangaMap in importedMangas) {
      String mangaId = mangaMap['mangaId'];

      List<Map<String, dynamic>> existing = await currentDb.query(
        'manga',
        where: 'mangaId = ?',
        whereArgs: [mangaId],
      );

      if (existing.isEmpty) {
        await currentDb.insert('manga', mangaMap);
      }
    }

    await importedDb.close();
  }
}
