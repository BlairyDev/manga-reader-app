import 'dart:async';
import 'package:manga_reader_app/data/model/database/manga.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
}
