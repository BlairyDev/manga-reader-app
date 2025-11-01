import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/database/manga.dart';

void main() {
  group('Manga model', () {
    final manga = Manga(
      id: 1,
      mangaId: 'm123',
      title: 'Naruto',
      description: 'A story about ninjas',
      authors: ['Masashi Kishimoto'],
      artists: ['Masashi Kishimoto'],
      tags: ['Action', 'Adventure'],
      coverArtUrl: 'https://example.com/naruto.jpg',
      status: 'Ongoing',
    );

    test('toMap serializes correctly', () {
      final map = manga.toMap();

      expect(map['id'], 1);
      expect(map['mangaId'], 'm123');
      expect(map['title'], 'Naruto');
      expect(map['description'], 'A story about ninjas');

      // Lists are encoded as JSON strings
      expect(jsonDecode(map['authors']), ['Masashi Kishimoto']);
      expect(jsonDecode(map['artists']), ['Masashi Kishimoto']);
      expect(jsonDecode(map['tags']), ['Action', 'Adventure']);

      expect(map['coverArtUrl'], 'https://example.com/naruto.jpg');
      expect(map['status'], 'Ongoing');
    });

    test('fromMap deserializes correctly', () {
      final map = {
        'id': 1,
        'mangaId': 'm123',
        'title': 'Naruto',
        'description': 'A story about ninjas',
        'authors': jsonEncode(['Masashi Kishimoto']),
        'artists': jsonEncode(['Masashi Kishimoto']),
        'tags': jsonEncode(['Action', 'Adventure']),
        'coverArtUrl': 'https://example.com/naruto.jpg',
        'status': 'Ongoing',
      };

      final result = Manga.fromMap(map);

      expect(result.id, 1);
      expect(result.mangaId, 'm123');
      expect(result.title, 'Naruto');
      expect(result.description, 'A story about ninjas');
      expect(result.authors, ['Masashi Kishimoto']);
      expect(result.artists, ['Masashi Kishimoto']);
      expect(result.tags, ['Action', 'Adventure']);
      expect(result.coverArtUrl, 'https://example.com/naruto.jpg');
      expect(result.status, 'Ongoing');
    });

    test('fromMap handles null lists correctly', () {
      final map = {
        'id': null,
        'mangaId': 'm123',
        'title': 'Naruto',
        'description': 'A story about ninjas',
        'authors': null,
        'artists': null,
        'tags': null,
        'coverArtUrl': 'https://example.com/naruto.jpg',
        'status': 'Ongoing',
      };

      final result = Manga.fromMap(map);

      expect(result.id, null);
      expect(result.authors, []);
      expect(result.artists, []);
      expect(result.tags, []);
    });

    test('round-trip serialization works', () {
      final map = manga.toMap();
      final result = Manga.fromMap(map);

      expect(result.id, manga.id);
      expect(result.mangaId, manga.mangaId);
      expect(result.title, manga.title);
      expect(result.description, manga.description);
      expect(result.authors, manga.authors);
      expect(result.artists, manga.artists);
      expect(result.tags, manga.tags);
      expect(result.coverArtUrl, manga.coverArtUrl);
      expect(result.status, manga.status);
    });
  });
}
