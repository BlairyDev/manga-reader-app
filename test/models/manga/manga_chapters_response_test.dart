import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';

void main() {
  group('MangaChaptersResponse model', () {
    test('fromJson parses nested volumes and chapters correctly', () {
      final json = {
        "result": "ok",
        "volumes": {
          "1": {
            "volume": "1",
            "count": 2,
            "chapters": {
              "1": {
                "chapter": "1",
                "id": "c1",
                "isUnavailable": false,
                "others": [],
                "count": 10,
              },
              "2": {
                "chapter": "2",
                "id": "c2",
                "isUnavailable": true,
                "others": ["extra"],
                "count": 12,
              },
            },
          },
        },
      };

      final response = MangaChaptersResponse.fromJson(json);

      expect(response.result, "ok");
      expect(response.volumes.length, 1);

      final volume = response.volumes["1"];
      expect(volume?.volume, "1");
      expect(volume?.count, 2);
      expect(volume?.chapters.length, 2);

      final chapter1 = volume?.chapters["1"];
      expect(chapter1?.chapter, "1");
      expect(chapter1?.id, "c1");
      expect(chapter1?.isUnavailable, false);
      expect(chapter1?.others, []);
      expect(chapter1?.count, 10);

      final chapter2 = volume?.chapters["2"];
      expect(chapter2?.chapter, "2");
      expect(chapter2?.id, "c2");
      expect(chapter2?.isUnavailable, true);
      expect(chapter2?.others, ["extra"]);
      expect(chapter2?.count, 12);
    });

    test('toJson serializes correctly', () {
      final chapter1 = Chapter(
        chapter: "1",
        id: "c1",
        isUnavailable: false,
        others: [],
        count: 10,
      );

      final chapter2 = Chapter(
        chapter: "2",
        id: "c2",
        isUnavailable: true,
        others: ["extra"],
        count: 12,
      );

      final volume = Volume(
        volume: "1",
        count: 2,
        chapters: {"1": chapter1, "2": chapter2},
      );

      final response = MangaChaptersResponse(
        result: "ok",
        volumes: {"1": volume},
      );

      final json = response.toJson();

      expect(json["result"], "ok");
      expect(json["volumes"]["1"]["volume"], "1");
      expect(json["volumes"]["1"]["count"], 2);
      expect(json["volumes"]["1"]["chapters"]["1"]["id"], "c1");
      expect(json["volumes"]["1"]["chapters"]["2"]["others"], ["extra"]);
    });

    test('fromJson handles empty volumes safely', () {
      final json = {"result": "ok", "volumes": null};

      final response = MangaChaptersResponse.fromJson(json);

      expect(response.result, "ok");
      expect(response.volumes, {});
    });

    test('round-trip serialization works', () {
      final chapter = Chapter(
        chapter: "1",
        id: "c1",
        isUnavailable: false,
        others: ["extra"],
        count: 10,
      );

      final volume = Volume(volume: "1", count: 1, chapters: {"1": chapter});

      final response = MangaChaptersResponse(
        result: "ok",
        volumes: {"1": volume},
      );

      final json = response.toJson();
      final newResponse = MangaChaptersResponse.fromJson(json);

      expect(newResponse.result, response.result);
      expect(newResponse.volumes.length, response.volumes.length);
      expect(newResponse.volumes["1"]?.chapters["1"]?.id, "c1");
      expect(newResponse.volumes["1"]?.chapters["1"]?.others, ["extra"]);
    });
  });
}
