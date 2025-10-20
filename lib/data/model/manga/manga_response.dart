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
    required this.ko,
    required this.koRo,
    required this.en,
    required this.fr,
    required this.es,
    required this.zh,
    required this.zhHk,
    required this.pl,
    required this.ru,
    required this.ptBr,
    required this.ja,
    required this.kk,
    required this.uk,
    required this.de,
    required this.tr,
    required this.tl,
    required this.ms,
    required this.th,
    required this.it,
    required this.vi,
    required this.pt,
    required this.bg,
    required this.fa,
    required this.ar,
    required this.ka,
    required this.esLa,
    required this.zhRo,
    required this.jaRo,
  });

  final String? ko;
  final String? koRo;
  final String? en;
  final String? fr;
  final String? es;
  final String? zh;
  final String? zhHk;
  final String? pl;
  final String? ru;
  final String? ptBr;
  final String? ja;
  final String? kk;
  final String? uk;
  final String? de;
  final String? tr;
  final String? tl;
  final String? ms;
  final String? th;
  final String? it;
  final String? vi;
  final String? pt;
  final String? bg;
  final String? fa;
  final String? ar;
  final String? ka;
  final String? esLa;
  final String? zhRo;
  final String? jaRo;

  factory AltTitle.fromJson(Map<String, dynamic> json) {
    return AltTitle(
      ko: json["ko"],
      koRo: json["ko-ro"],
      en: json["en"],
      fr: json["fr"],
      es: json["es"],
      zh: json["zh"],
      zhHk: json["zh-hk"],
      pl: json["pl"],
      ru: json["ru"],
      ptBr: json["pt-br"],
      ja: json["ja"],
      kk: json["kk"],
      uk: json["uk"],
      de: json["de"],
      tr: json["tr"],
      tl: json["tl"],
      ms: json["ms"],
      th: json["th"],
      it: json["it"],
      vi: json["vi"],
      pt: json["pt"],
      bg: json["bg"],
      fa: json["fa"],
      ar: json["ar"],
      ka: json["ka"],
      esLa: json["es-la"],
      zhRo: json["zh-ro"],
      jaRo: json["ja-ro"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ko": ko,
    "ko-ro": koRo,
    "en": en,
    "fr": fr,
    "es": es,
    "zh": zh,
    "zh-hk": zhHk,
    "pl": pl,
    "ru": ru,
    "pt-br": ptBr,
    "ja": ja,
    "kk": kk,
    "uk": uk,
    "de": de,
    "tr": tr,
    "tl": tl,
    "ms": ms,
    "th": th,
    "it": it,
    "vi": vi,
    "pt": pt,
    "bg": bg,
    "fa": fa,
    "ar": ar,
    "ka": ka,
    "es-la": esLa,
    "zh-ro": zhRo,
    "ja-ro": jaRo,
  };
}

class PurpleDescription {
  PurpleDescription({
    required this.en,
    required this.ko,
    required this.zh,
    required this.zhHk,
    required this.de,
    required this.es,
    required this.fr,
    required this.id,
    required this.ja,
    required this.th,
    required this.ptBr,
    required this.pl,
    required this.ru,
    required this.uk,
    required this.vi,
    required this.pt,
    required this.tr,
    required this.esLa,
  });

  final String? en;
  final String? ko;
  final String? zh;
  final String? zhHk;
  final String? de;
  final String? es;
  final String? fr;
  final String? id;
  final String? ja;
  final String? th;
  final String? ptBr;
  final String? pl;
  final String? ru;
  final String? uk;
  final String? vi;
  final String? pt;
  final String? tr;
  final String? esLa;

  factory PurpleDescription.fromJson(Map<String, dynamic> json) {
    return PurpleDescription(
      en: json["en"],
      ko: json["ko"],
      zh: json["zh"],
      zhHk: json["zh-hk"],
      de: json["de"],
      es: json["es"],
      fr: json["fr"],
      id: json["id"],
      ja: json["ja"],
      th: json["th"],
      ptBr: json["pt-br"],
      pl: json["pl"],
      ru: json["ru"],
      uk: json["uk"],
      vi: json["vi"],
      pt: json["pt"],
      tr: json["tr"],
      esLa: json["es-la"],
    );
  }

  Map<String, dynamic> toJson() => {
    "en": en,
    "ko": ko,
    "zh": zh,
    "zh-hk": zhHk,
    "de": de,
    "es": es,
    "fr": fr,
    "id": id,
    "ja": ja,
    "th": th,
    "pt-br": ptBr,
    "pl": pl,
    "ru": ru,
    "uk": uk,
    "vi": vi,
    "pt": pt,
    "tr": tr,
    "es-la": esLa,
  };
}

class Links {
  Links({
    required this.al,
    required this.ap,
    required this.mu,
    required this.nu,
    required this.mal,
    required this.raw,
    required this.engtl,
    required this.kt,
    required this.bw,
    required this.amz,
    required this.cdj,
    required this.ebj,
  });

  final String? al;
  final String? ap;
  final String? mu;
  final String? nu;
  final String? mal;
  final String? raw;
  final String? engtl;
  final String? kt;
  final String? bw;
  final String? amz;
  final String? cdj;
  final String? ebj;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      al: json["al"],
      ap: json["ap"],
      mu: json["mu"],
      nu: json["nu"],
      mal: json["mal"],
      raw: json["raw"],
      engtl: json["engtl"],
      kt: json["kt"],
      bw: json["bw"],
      amz: json["amz"],
      cdj: json["cdj"],
      ebj: json["ebj"],
    );
  }

  Map<String, dynamic> toJson() => {
    "al": al,
    "ap": ap,
    "mu": mu,
    "nu": nu,
    "mal": mal,
    "raw": raw,
    "engtl": engtl,
    "kt": kt,
    "bw": bw,
    "amz": amz,
    "cdj": cdj,
    "ebj": ebj,
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

  final Title? name;
  final FluffyDescription? description;
  final String? group;
  final int? version;

  factory TagAttributes.fromJson(Map<String, dynamic> json) {
    return TagAttributes(
      name: json["name"] == null ? null : Title.fromJson(json["name"]),
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

class Title {
  Title({required this.en, required this.jaRo, required this.ja});

  final String? en;
  final String? jaRo;
  final String? ja;

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(en: json["en"], jaRo: json["ja-ro"], ja: json["ja"]);
  }

  Map<String, dynamic> toJson() => {"en": en};
}

class Relationship {
  Relationship({
    required this.id,
    required this.type,
    required this.attributes,
    required this.related,
  });

  final String? id;
  final String? type;
  final RelationshipAttributes? attributes;
  final String? related;

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
      id: json["id"],
      type: json["type"],
      attributes: json["attributes"] == null
          ? null
          : RelationshipAttributes.fromJson(json["attributes"]),
      related: json["related"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes?.toJson(),
    "related": related,
  };
}

class RelationshipAttributes {
  RelationshipAttributes({
    required this.name,
    required this.imageUrl,
    required this.biography,
    required this.twitter,
    required this.pixiv,
    required this.melonBook,
    required this.fanBox,
    required this.booth,
    required this.namicomi,
    required this.nicoVideo,
    required this.skeb,
    required this.fantia,
    required this.tumblr,
    required this.youtube,
    required this.weibo,
    required this.naver,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.description,
    required this.volume,
    required this.fileName,
    required this.locale,
  });

  final String? name;
  final dynamic imageUrl;
  final Biography? biography;
  final String? twitter;
  final String? pixiv;
  final dynamic melonBook;
  final dynamic fanBox;
  final String? booth;
  final dynamic namicomi;
  final dynamic nicoVideo;
  final dynamic skeb;
  final dynamic fantia;
  final dynamic tumblr;
  final dynamic youtube;
  final dynamic weibo;
  final String? naver;
  final String? website;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;
  final String? description;
  final String? volume;
  final String? fileName;
  final String? locale;

  factory RelationshipAttributes.fromJson(Map<String, dynamic> json) {
    return RelationshipAttributes(
      name: json["name"],
      imageUrl: json["imageUrl"],
      biography: json["biography"] == null
          ? null
          : Biography.fromJson(json["biography"]),
      twitter: json["twitter"],
      pixiv: json["pixiv"],
      melonBook: json["melonBook"],
      fanBox: json["fanBox"],
      booth: json["booth"],
      namicomi: json["namicomi"],
      nicoVideo: json["nicoVideo"],
      skeb: json["skeb"],
      fantia: json["fantia"],
      tumblr: json["tumblr"],
      youtube: json["youtube"],
      weibo: json["weibo"],
      naver: json["naver"],
      website: json["website"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      version: json["version"],
      description: json["description"],
      volume: json["volume"],
      fileName: json["fileName"],
      locale: json["locale"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "imageUrl": imageUrl,
    "biography": biography?.toJson(),
    "twitter": twitter,
    "pixiv": pixiv,
    "melonBook": melonBook,
    "fanBox": fanBox,
    "booth": booth,
    "namicomi": namicomi,
    "nicoVideo": nicoVideo,
    "skeb": skeb,
    "fantia": fantia,
    "tumblr": tumblr,
    "youtube": youtube,
    "weibo": weibo,
    "naver": naver,
    "website": website,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "version": version,
    "description": description,
    "volume": volume,
    "fileName": fileName,
    "locale": locale,
  };
}

class Biography {
  Biography({
    required this.en,
    required this.es,
    required this.esLa,
    required this.ptBr,
  });

  final String? en;
  final String? es;
  final String? esLa;
  final String? ptBr;

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      en: json["en"],
      es: json["es"],
      esLa: json["es-la"],
      ptBr: json["pt-br"],
    );
  }

  Map<String, dynamic> toJson() => {
    "en": en,
    "es": es,
    "es-la": esLa,
    "pt-br": ptBr,
  };
}
