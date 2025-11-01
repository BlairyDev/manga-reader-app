import 'package:flutter_test/flutter_test.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapter_image_list_response.dart';

void main() {
  group('Chapter model', () {
    test('fromJson parses correctly', () {
      final json = {
        "hash": "abcd123",
        "data": ["img1.jpg", "img2.jpg"],
        "dataSaver": ["img1_saver.jpg", "img2_saver.jpg"],
      };

      final chapter = Chapter.fromJson(json);

      expect(chapter.hash, "abcd123");
      expect(chapter.data, ["img1.jpg", "img2.jpg"]);
      expect(chapter.dataSaver, ["img1_saver.jpg", "img2_saver.jpg"]);
    });

    test('toJson serializes correctly', () {
      final chapter = Chapter(
        hash: "abcd123",
        data: ["img1.jpg", "img2.jpg"],
        dataSaver: ["img1_saver.jpg", "img2_saver.jpg"],
      );

      final json = chapter.toJson();

      expect(json["hash"], "abcd123");
      expect(json["data"], ["img1.jpg", "img2.jpg"]);
      expect(json["dataSaver"], ["img1_saver.jpg", "img2_saver.jpg"]);
    });

    test('fromJson handles null lists correctly', () {
      final json = {"hash": "abcd123", "data": null, "dataSaver": null};

      final chapter = Chapter.fromJson(json);

      expect(chapter.data, []);
      expect(chapter.dataSaver, []);
    });
  });

  group('MangaChapterImageList model', () {
    test('fromJson parses nested chapter correctly', () {
      final json = {
        "result": "ok",
        "baseUrl": "https://example.com",
        "chapter": {
          "hash": "abcd123",
          "data": ["img1.jpg"],
          "dataSaver": ["img1_saver.jpg"],
        },
      };

      final model = MangaChapterImageList.fromJson(json);

      expect(model.result, "ok");
      expect(model.baseUrl, "https://example.com");
      expect(model.chapter?.hash, "abcd123");
      expect(model.chapter?.data, ["img1.jpg"]);
      expect(model.chapter?.dataSaver, ["img1_saver.jpg"]);
    });

    test('toJson serializes nested chapter correctly', () {
      final chapter = Chapter(
        hash: "abcd123",
        data: ["img1.jpg"],
        dataSaver: ["img1_saver.jpg"],
      );

      final model = MangaChapterImageList(
        result: "ok",
        baseUrl: "https://example.com",
        chapter: chapter,
      );

      final json = model.toJson();

      expect(json["result"], "ok");
      expect(json["baseUrl"], "https://example.com");
      expect(json["chapter"]["hash"], "abcd123");
      expect(json["chapter"]["data"], ["img1.jpg"]);
      expect(json["chapter"]["dataSaver"], ["img1_saver.jpg"]);
    });

    test('fromJson handles null chapter correctly', () {
      final json = {
        "result": "ok",
        "baseUrl": "https://example.com",
        "chapter": null,
      };

      final model = MangaChapterImageList.fromJson(json);

      expect(model.result, "ok");
      expect(model.baseUrl, "https://example.com");
      expect(model.chapter, null);
    });
  });

  test('round-trip serialization works', () {
    final chapter = Chapter(
      hash: "abcd123",
      data: ["img1.jpg"],
      dataSaver: ["img1_saver.jpg"],
    );

    final model = MangaChapterImageList(
      result: "ok",
      baseUrl: "https://example.com",
      chapter: chapter,
    );

    final json = model.toJson();
    final newModel = MangaChapterImageList.fromJson(json);

    expect(newModel.result, model.result);
    expect(newModel.baseUrl, model.baseUrl);
    expect(newModel.chapter?.hash, model.chapter?.hash);
    expect(newModel.chapter?.data, model.chapter?.data);
    expect(newModel.chapter?.dataSaver, model.chapter?.dataSaver);
  });
}
