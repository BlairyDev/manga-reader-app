class MangaChaptersResponse {
  MangaChaptersResponse({required this.result, required this.volumes});

  final String? result;
  final Map<String, Volume> volumes;

  factory MangaChaptersResponse.fromJson(Map<String, dynamic> json) {
    return MangaChaptersResponse(
      result: json["result"],
      volumes: (json["volumes"] == null || json["volumes"] is List)
          ? <String, Volume>{}
          : Map.from(
              json["volumes"],
            ).map((k, v) => MapEntry<String, Volume>(k, Volume.fromJson(v))),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "volumes": Map.from(
      volumes,
    ).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
  };
}

class Volume {
  Volume({required this.volume, required this.count, required this.chapters});

  final String? volume;
  final int? count;
  final Map<String, Chapter> chapters;

  factory Volume.fromJson(Map<String, dynamic> json) {
    return Volume(
      volume: json["volume"],
      count: json["count"],
      chapters: Map.from(
        json["chapters"],
      ).map((k, v) => MapEntry<String, Chapter>(k, Chapter.fromJson(v))),
    );
  }

  Map<String, dynamic> toJson() => {
    "volume": volume,
    "count": count,
    "chapters": Map.from(
      chapters,
    ).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
  };
}

class Chapter {
  Chapter({
    required this.chapter,
    required this.id,
    required this.isUnavailable,
    required this.others,
    required this.count,
  });

  final String? chapter;
  final String? id;
  final bool? isUnavailable;
  final List<dynamic> others;
  final int? count;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapter: json["chapter"],
      id: json["id"],
      isUnavailable: json["isUnavailable"],
      others: json["others"] == null
          ? []
          : List<dynamic>.from(json["others"]!.map((x) => x)),
      count: json["count"],
    );
  }

  Map<String, dynamic> toJson() => {
    "chapter": chapter,
    "id": id,
    "isUnavailable": isUnavailable,
    "others": others.map((x) => x).toList(),
    "count": count,
  };
}
