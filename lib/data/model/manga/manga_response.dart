class MangaResponse {
  MangaResponse({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  final String? result;
  final String? response;
  final List<MangaData> data;
  final int? limit;
  final int? offset;
  final int? total;

  factory MangaResponse.fromJson(Map<String, dynamic> json) {
    return MangaResponse(
      result: json["result"],
      response: json["response"],
      data: json["data"] == null
          ? []
          : List<MangaData>.from(
              json["data"]!.map((x) => MangaData.fromJson(x)),
            ),
      limit: json["limit"],
      offset: json["offset"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "response": response,
    "data": data.map((x) => x?.toJson()).toList(),
    "limit": limit,
    "offset": offset,
    "total": total,
  };
}

class MangaData {
  MangaData({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  final String? id;
  final String? type;
  final MangaAttributes? attributes;
  final List<Relationship> relationships;

  factory MangaData.fromJson(Map<String, dynamic> json) {
    return MangaData(
      id: json["id"],
      type: json["type"],
      attributes: json["attributes"] == null
          ? null
          : MangaAttributes.fromJson(json["attributes"]),
      relationships: json["relationships"] == null
          ? []
          : List<Relationship>.from(
              json["relationships"]!.map((x) => Relationship.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes?.toJson(),
    "relationships": relationships.map((x) => x?.toJson()).toList(),
  };
}

class MangaAttributes {
  MangaAttributes({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.isLocked,
    required this.links,
    required this.officialLinks,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    required this.publicationDemographic,
    required this.status,
    required this.year,
    required this.contentRating,
    required this.tags,
    required this.state,
    required this.chapterNumbersResetOnNewVolume,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.availableTranslatedLanguages,
    required this.latestUploadedChapter,
  });

  final Title? title;
  final List<AltTitle> altTitles;
  final PurpleDescription? description;
  final bool? isLocked;
  final Links? links;
  final dynamic officialLinks;
  final String? originalLanguage;
  final String? lastVolume;
  final String? lastChapter;
  final String? publicationDemographic;
  final String? status;
  final int? year;
  final String? contentRating;
  final List<Tag> tags;
  final String? state;
  final bool? chapterNumbersResetOnNewVolume;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;
  final List<String> availableTranslatedLanguages;
  final String? latestUploadedChapter;

  factory MangaAttributes.fromJson(Map<String, dynamic> json) {
    return MangaAttributes(
      title: json["title"] == null ? null : Title.fromJson(json["title"]),
      altTitles: json["altTitles"] == null
          ? []
          : List<AltTitle>.from(
              json["altTitles"]!.map((x) => AltTitle.fromJson(x)),
            ),
      description: json["description"] == null
          ? null
          : PurpleDescription.fromJson(json["description"]),
      isLocked: json["isLocked"],
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      officialLinks: json["officialLinks"],
      originalLanguage: json["originalLanguage"],
      lastVolume: json["lastVolume"],
      lastChapter: json["lastChapter"],
      publicationDemographic: json["publicationDemographic"],
      status: json["status"],
      year: json["year"],
      contentRating: json["contentRating"],
      tags: json["tags"] == null
          ? []
          : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      state: json["state"],
      chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      version: json["version"],
      availableTranslatedLanguages: json["availableTranslatedLanguages"] == null
          ? []
          : List<String>.from(
              json["availableTranslatedLanguages"]!.map((x) => x),
            ),
      latestUploadedChapter: json["latestUploadedChapter"],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title?.toJson(),
    "altTitles": altTitles.map((x) => x?.toJson()).toList(),
    "description": description?.toJson(),
    "isLocked": isLocked,
    "links": links?.toJson(),
    "officialLinks": officialLinks,
    "originalLanguage": originalLanguage,
    "lastVolume": lastVolume,
    "lastChapter": lastChapter,
    "publicationDemographic": publicationDemographic,
    "status": status,
    "year": year,
    "contentRating": contentRating,
    "tags": tags.map((x) => x?.toJson()).toList(),
    "state": state,
    "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "version": version,
    "availableTranslatedLanguages": availableTranslatedLanguages
        .map((x) => x)
        .toList(),
    "latestUploadedChapter": latestUploadedChapter,
  };
}

class AltTitle {
  AltTitle({
    required this.ja,
    required this.en,
    required this.zhHk,
    required this.fr,
    required this.pl,
    required this.ptBr,
    required this.ru,
    required this.es,
    required this.esLa,
    required this.vi,
    required this.ko,
    required this.jaRo,
    required this.zh,
    required this.tr,
    required this.uk,
    required this.zhRo,
    required this.id,
    required this.th,
  });

  final String? ja;
  final String? en;
  final String? zhHk;
  final String? fr;
  final String? pl;
  final String? ptBr;
  final String? ru;
  final String? es;
  final String? esLa;
  final String? vi;
  final String? ko;
  final String? jaRo;
  final String? zh;
  final String? tr;
  final String? uk;
  final String? zhRo;
  final String? id;
  final String? th;

  factory AltTitle.fromJson(Map<String, dynamic> json) {
    return AltTitle(
      ja: json["ja"],
      en: json["en"],
      zhHk: json["zh-hk"],
      fr: json["fr"],
      pl: json["pl"],
      ptBr: json["pt-br"],
      ru: json["ru"],
      es: json["es"],
      esLa: json["es-la"],
      vi: json["vi"],
      ko: json["ko"],
      jaRo: json["ja-ro"],
      zh: json["zh"],
      tr: json["tr"],
      uk: json["uk"],
      zhRo: json["zh-ro"],
      id: json["id"],
      th: json["th"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ja": ja,
    "en": en,
    "zh-hk": zhHk,
    "fr": fr,
    "pl": pl,
    "pt-br": ptBr,
    "ru": ru,
    "es": es,
    "es-la": esLa,
    "vi": vi,
    "ko": ko,
    "ja-ro": jaRo,
    "zh": zh,
    "tr": tr,
    "uk": uk,
    "zh-ro": zhRo,
    "id": id,
    "th": th,
  };
}

class PurpleDescription {
  PurpleDescription({
    required this.en,
    required this.ja,
    required this.es,
    required this.fr,
    required this.pl,
    required this.ru,
    required this.vi,
    required this.esLa,
    required this.ptBr,
    required this.id,
    required this.uk,
    required this.tr,
  });

  final String? en;
  final String? ja;
  final String? es;
  final String? fr;
  final String? pl;
  final String? ru;
  final String? vi;
  final String? esLa;
  final String? ptBr;
  final String? id;
  final String? uk;
  final String? tr;

  factory PurpleDescription.fromJson(Map<String, dynamic> json) {
    return PurpleDescription(
      en: json["en"],
      ja: json["ja"],
      es: json["es"],
      fr: json["fr"],
      pl: json["pl"],
      ru: json["ru"],
      vi: json["vi"],
      esLa: json["es-la"],
      ptBr: json["pt-br"],
      id: json["id"],
      uk: json["uk"],
      tr: json["tr"],
    );
  }

  Map<String, dynamic> toJson() => {
    "en": en,
    "ja": ja,
    "es": es,
    "fr": fr,
    "pl": pl,
    "ru": ru,
    "vi": vi,
    "es-la": esLa,
    "pt-br": ptBr,
    "id": id,
    "uk": uk,
    "tr": tr,
  };
}

class Links {
  Links({
    required this.al,
    required this.ap,
    required this.bw,
    required this.mu,
    required this.amz,
    required this.ebj,
    required this.mal,
    required this.raw,
    required this.kt,
    required this.cdj,
    required this.engtl,
    required this.nu,
  });

  final String? al;
  final String? ap;
  final String? bw;
  final String? mu;
  final String? amz;
  final String? ebj;
  final String? mal;
  final String? raw;
  final String? kt;
  final String? cdj;
  final String? engtl;
  final String? nu;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      al: json["al"],
      ap: json["ap"],
      bw: json["bw"],
      mu: json["mu"],
      amz: json["amz"],
      ebj: json["ebj"],
      mal: json["mal"],
      raw: json["raw"],
      kt: json["kt"],
      cdj: json["cdj"],
      engtl: json["engtl"],
      nu: json["nu"],
    );
  }

  Map<String, dynamic> toJson() => {
    "al": al,
    "ap": ap,
    "bw": bw,
    "mu": mu,
    "amz": amz,
    "ebj": ebj,
    "mal": mal,
    "raw": raw,
    "kt": kt,
    "cdj": cdj,
    "engtl": engtl,
    "nu": nu,
  };
}

class Tag {
  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  final String? id;
  final String? type;
  final TagAttributes? attributes;
  final List<dynamic> relationships;

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"],
      type: json["type"],
      attributes: json["attributes"] == null
          ? null
          : TagAttributes.fromJson(json["attributes"]),
      relationships: json["relationships"] == null
          ? []
          : List<dynamic>.from(json["relationships"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes?.toJson(),
    "relationships": relationships.map((x) => x).toList(),
  };
}

class TagAttributes {
  TagAttributes({
    required this.name,
    required this.description,
    required this.group,
    required this.version,
  });

  final Name? name;
  final FluffyDescription? description;
  final String? group;
  final int? version;

  factory TagAttributes.fromJson(Map<String, dynamic> json) {
    return TagAttributes(
      name: json["name"] == null ? null : Name.fromJson(json["name"]),
      description: json["description"] == null
          ? null
          : FluffyDescription.fromJson(json["description"]),
      group: json["group"],
      version: json["version"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name?.toJson(),
    "description": description?.toJson(),
    "group": group,
    "version": version,
  };
}

class FluffyDescription {
  FluffyDescription({required this.json});
  final Map<String, dynamic> json;

  factory FluffyDescription.fromJson(Map<String, dynamic> json) {
    return FluffyDescription(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class Name {
  Name({required this.en});

  final String? en;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(en: json["en"]);
  }

  Map<String, dynamic> toJson() => {"en": en};
}

class Title {
  Title({required this.en, required this.zhRo});

  final String? en;
  final String? zhRo;

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(en: json["en"], zhRo: json["zh-ro"]);
  }

  Map<String, dynamic> toJson() => {"en": en, "zh-ro": zhRo};
}

class Relationship {
  Relationship({required this.id, required this.type, required this.related});

  final String? id;
  final String? type;
  final String? related;

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      id: json["id"],
      type: json["type"],
      related: json["related"],
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "type": type, "related": related};
}
