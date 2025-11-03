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
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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
        String nameOnly = basenameWithoutExtension('manga_export.txt');
        String ext = extension('manga_export.txt');
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

  Future<bool> importDatabase() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['.txt'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();

        final decoded = json.decode(content);

        for (var item in decoded) {
          String authorsString = item['authors'];
          List<String> authors = List<String>.from(jsonDecode(authorsString));

          String artistsString = item['artists'];
          List<String> artists = List<String>.from(jsonDecode(artistsString));

          String tagsString = item['tags'];
          List<String> tags = List<String>.from(jsonDecode(tagsString));

          Manga manga = Manga(
            mangaId: item['mangaId'],
            title: item['title'],
            description: item['description'],
            authors: authors,
            artists: artists,
            tags: tags,
            coverArtUrl: item['coverArtUrl'],
            status: item['status'],
          );

          if (!(await checkInLibrary(manga.mangaId))) {
            insertManga(manga);
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
