import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_response.dart';

void main() {
  group('MangaResponse model', () {
    test('fromJson parses nested structure correctly', () {
      final json = {
        "result": "ok",
        "response": "collection",
        "data": [
          {
            "id": "m1",
            "type": "manga",
            "attributes": {
              "title": {"en": "Naruto"},
              "altTitles": [],
              "description": {"en": "A story about ninjas"},
              "isLocked": false,
              "links": {"al": "link"},
              "officialLinks": null,
              "originalLanguage": "en",
              "lastVolume": "72",
              "lastChapter": "700",
              "publicationDemographic": "shonen",
              "status": "completed",
              "year": 1999,
              "contentRating": "safe",
              "tags": [],
              "state": "published",
              "chapterNumbersResetOnNewVolume": false,
              "createdAt": "2000-01-01T00:00:00.000Z",
              "updatedAt": "2000-01-01T00:00:00.000Z",
              "version": 1,
              "availableTranslatedLanguages": ["en", "ja"],
              "latestUploadedChapter": "700",
            },
            "relationships": [],
          },
        ],
        "limit": 10,
        "offset": 0,
        "total": 1,
      };

      final response = MangaResponse.fromJson(json);

      expect(response.result, "ok");
      expect(response.response, "collection");
      expect(response.limit, 10);
      expect(response.offset, 0);
      expect(response.total, 1);
      expect(response.data.length, 1);

      final mangaData = response.data.first;
      expect(mangaData.id, "m1");
      expect(mangaData.type, "manga");
      expect(mangaData.attributes?.title?.en, "Naruto");
      expect(mangaData.attributes?.description?.en, "A story about ninjas");
      expect(mangaData.attributes?.year, 1999);
      expect(mangaData.attributes?.availableTranslatedLanguages, ["en", "ja"]);
    });

    test('toJson serializes correctly', () {
      final attributes = MangaAttributes(
        title: Title(en: "Naruto"),
        altTitles: [],
        description: PurpleDescription(
          en: "A story about ninjas",
          ko: null,
          zh: null,
          zhHk: null,
          de: null,
          es: null,
          fr: null,
          id: null,
          ja: null,
          th: null,
          ptBr: null,
          pl: null,
          ru: null,
          uk: null,
          vi: null,
          pt: null,
          tr: null,
          esLa: null,
        ),
        isLocked: false,
        links: Links(
          al: "link",
          ap: null,
          mu: null,
          nu: null,
          mal: null,
          raw: null,
          engtl: null,
          kt: null,
          bw: null,
          amz: null,
          cdj: null,
          ebj: null,
        ),
        officialLinks: null,
        originalLanguage: "en",
        lastVolume: "72",
        lastChapter: "700",
        publicationDemographic: "shonen",
        status: "completed",
        year: 1999,
        contentRating: "safe",
        tags: [],
        state: "published",
        chapterNumbersResetOnNewVolume: false,
        createdAt: DateTime.parse("2000-01-01T00:00:00.000Z"),
        updatedAt: DateTime.parse("2000-01-01T00:00:00.000Z"),
        version: 1,
        availableTranslatedLanguages: ["en", "ja"],
        latestUploadedChapter: "700",
      );

      final mangaData = MangaData(
        id: "m1",
        type: "manga",
        attributes: attributes,
        relationships: [],
      );

      final response = MangaResponse(
        result: "ok",
        response: "collection",
        data: [mangaData],
        limit: 10,
        offset: 0,
        total: 1,
      );

      final json = response.toJson();

      expect(json["result"], "ok");
      expect(json["response"], "collection");
      expect(json["limit"], 10);
      expect(json["offset"], 0);
      expect(json["total"], 1);
      expect(json["data"].length, 1);
      expect(json["data"][0]["id"], "m1");
      expect(json["data"][0]["attributes"]["title"]["en"], "Naruto");
    });

    test('round-trip serialization works', () {
      final attributes = MangaAttributes(
        title: Title(en: "Naruto"),
        altTitles: [],
        description: PurpleDescription(
          en: "A story about ninjas",
          ko: null,
          zh: null,
          zhHk: null,
          de: null,
          es: null,
          fr: null,
          id: null,
          ja: null,
          th: null,
          ptBr: null,
          pl: null,
          ru: null,
          uk: null,
          vi: null,
          pt: null,
          tr: null,
          esLa: null,
        ),
        isLocked: false,
        links: Links(
          al: "link",
          ap: null,
          mu: null,
          nu: null,
          mal: null,
          raw: null,
          engtl: null,
          kt: null,
          bw: null,
          amz: null,
          cdj: null,
          ebj: null,
        ),
        officialLinks: null,
        originalLanguage: "en",
        lastVolume: "72",
        lastChapter: "700",
        publicationDemographic: "shonen",
        status: "completed",
        year: 1999,
        contentRating: "safe",
        tags: [],
        state: "published",
        chapterNumbersResetOnNewVolume: false,
        createdAt: DateTime.parse("2000-01-01T00:00:00.000Z"),
        updatedAt: DateTime.parse("2000-01-01T00:00:00.000Z"),
        version: 1,
        availableTranslatedLanguages: ["en", "ja"],
        latestUploadedChapter: "700",
      );

      final mangaData = MangaData(
        id: "m1",
        type: "manga",
        attributes: attributes,
        relationships: [],
      );

      final response = MangaResponse(
        result: "ok",
        response: "collection",
        data: [mangaData],
        limit: 10,
        offset: 0,
        total: 1,
      );

      final json = response.toJson();
      final newResponse = MangaResponse.fromJson(json);

      expect(newResponse.result, response.result);
      expect(newResponse.response, response.response);
      expect(newResponse.data[0].id, response.data[0].id);
      expect(
        newResponse.data[0].attributes?.title?.en,
        response.data[0].attributes?.title?.en,
      );
    });
  });
}
