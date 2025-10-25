import 'dart:convert';

class Manga {
  final int? id;
  final String mangaId;
  final String title;
  final String description;
  final List<String> authors;
  final List<String> artists;
  final List<String> tags;
  final String coverArtUrl;
  final String status;

  Manga({
    this.id,
    required this.mangaId,
    required this.title,
    required this.description,
    required this.authors,
    required this.artists,
    required this.tags,
    required this.coverArtUrl,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mangaId': mangaId,
      'title': title,
      'description': description,
      'authors': jsonEncode(authors),
      'artists': jsonEncode(artists),
      'tags': jsonEncode(tags),
      'coverArtUrl': coverArtUrl,
      'status': status,
    };
  }

  factory Manga.fromMap(Map<String, dynamic> map) {
    return Manga(
      id: map['id'],
      mangaId: map['mangaId'],
      title: map['title'],
      description: map['description'],
      authors: map['authors'] != null
          ? List<String>.from(jsonDecode(map['authors']))
          : [],
      artists: map['artists'] != null
          ? List<String>.from(jsonDecode(map['artists']))
          : [],
      tags: map['tags'] != null
          ? List<String>.from(jsonDecode(map['tags']))
          : [],
      coverArtUrl: map['coverArtUrl'],
      status: map['status'],
    );
  }
}
