class MangaChapterImageList {
  MangaChapterImageList({
    required this.result,
    required this.baseUrl,
    required this.chapter,
  });

  final String? result;
  final String? baseUrl;
  final Chapter? chapter;

  factory MangaChapterImageList.fromJson(Map<String, dynamic> json) {
    return MangaChapterImageList(
      result: json["result"],
      baseUrl: json["baseUrl"],
      chapter: json["chapter"] == null
          ? null
          : Chapter.fromJson(json["chapter"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "baseUrl": baseUrl,
    "chapter": chapter?.toJson(),
  };
}

class Chapter {
  Chapter({required this.hash, required this.data, required this.dataSaver});

  final String? hash;
  final List<String> data;
  final List<String> dataSaver;

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      hash: json["hash"],
      data: json["data"] == null
          ? []
          : List<String>.from(json["data"]!.map((x) => x)),
      dataSaver: json["dataSaver"] == null
          ? []
          : List<String>.from(json["dataSaver"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "data": data.map((x) => x).toList(),
    "dataSaver": dataSaver.map((x) => x).toList(),
  };
}
