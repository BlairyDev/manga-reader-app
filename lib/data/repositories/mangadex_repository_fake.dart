import 'package:manga_reader_app/data/model/manga/manga_response.dart';
import 'package:manga_reader_app/data/model/manga/manga_chapters_response.dart';
import 'package:manga_reader_app/data/repositories/mangadex_repository.dart';

List<MangaData> fakeMangaList = [
  MangaData(
    id: "1",
    type: "manga",
    attributes: MangaAttributes(
      title: Title(en: "Naruto", zhRo: "火影忍者"),
      altTitles: [
        AltTitle(
          ja: "ナルト",
          en: "Naruto",
          zhHk: "火影忍者",
          fr: "Naruto",
          pl: "Naruto",
          ptBr: "Naruto",
          ru: "Наруто",
          es: "Naruto",
          esLa: "Naruto",
          vi: "Naruto",
          ko: "나루토",
          jaRo: "Naruto",
          zh: "火影忍者",
          tr: "Naruto",
          uk: "Наруто",
          zhRo: "火影忍者",
          id: "naruto-id",
          th: "นารูโตะ",
        ),
      ],
      description: PurpleDescription(
        en: "A young ninja strives to be the strongest.",
        ja: "若い忍者が最強を目指している。",
        es: "Un joven ninja lucha por ser el más fuerte.",
        fr: "Un jeune ninja lutte pour devenir le plus fort.",
        pl: "Młody ninja stara się być najsilniejszy.",
        ru: "Молодой ниндзя стремится стать самым сильным.",
        vi: "Một ninja trẻ cố gắng trở thành mạnh nhất.",
        esLa: "Un joven ninja lucha por ser el más fuerte.",
        ptBr: "Um jovem ninja tenta ser o mais forte.",
        id: "description-id",
        uk: "Молодий ніндзя прагне стати найсильнішим.",
        tr: "Genç bir ninja en güçlü olmak için çabalıyor.",
      ),
      isLocked: false,
      links: Links(
        al: "https://example.com",
        ap: "https://example.com",
        bw: "https://example.com",
        mu: "https://example.com",
        amz: "https://example.com",
        ebj: "https://example.com",
        mal: "https://example.com",
        raw: "https://example.com",
        kt: "https://example.com",
        cdj: "https://example.com",
        engtl: "https://example.com",
        nu: "https://example.com",
      ),
      officialLinks: null,
      originalLanguage: "ja",
      lastVolume: "72",
      lastChapter: "700",
      publicationDemographic: "Shonen",
      status: "Completed",
      year: 1999,
      contentRating: "PG-13",
      tags: [],
      state: "Finished",
      chapterNumbersResetOnNewVolume: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
      availableTranslatedLanguages: ["en", "es", "fr", "de"],
      latestUploadedChapter: "700",
    ),
    relationships: [
      Relationship(id: "2", type: "author", related: "Masashi Kishimoto"),
    ],
  ),
  MangaData(
    id: "2",
    type: "manga",
    attributes: MangaAttributes(
      title: Title(en: "One Piece", zhRo: "海賊王"),
      altTitles: [
        AltTitle(
          ja: "ワンピース",
          en: "One Piece",
          zhHk: "海賊王",
          fr: "One Piece",
          pl: "One Piece",
          ptBr: "One Piece",
          ru: "Ван Пис",
          es: "One Piece",
          esLa: "One Piece",
          vi: "One Piece",
          ko: "원피스",
          jaRo: "One Piece",
          zh: "海賊王",
          tr: "One Piece",
          uk: "Ван Піс",
          zhRo: "海賊王",
          id: "one-piece-id",
          th: "วันพีช",
        ),
      ],
      description: PurpleDescription(
        en: "A pirate's quest for the greatest treasure.",
        ja: "海賊が最も偉大な財宝を求める物語。",
        es: "La búsqueda de un pirata por el mayor tesoro.",
        fr: "La quête d'un pirate pour le plus grand trésor.",
        pl: "Poszukiwanie największego skarbu przez pirata.",
        ru: "Поиск самого великого сокровища пиратом.",
        vi: "Cuộc hành trình của một tên cướp biển để tìm kiếm kho báu lớn nhất.",
        esLa: "La búsqueda de un pirata por el mayor tesoro.",
        ptBr: "A busca de um pirata pelo maior tesouro.",
        id: "description-id",
        uk: "Подорож пірата за найбільшим скарбом.",
        tr: "Bir korsanın en büyük hazinenin peşinden gitmesi.",
      ),
      isLocked: false,
      links: Links(
        al: "https://example.com",
        ap: "https://example.com",
        bw: "https://example.com",
        mu: "https://example.com",
        amz: "https://example.com",
        ebj: "https://example.com",
        mal: "https://example.com",
        raw: "https://example.com",
        kt: "https://example.com",
        cdj: "https://example.com",
        engtl: "https://example.com",
        nu: "https://example.com",
      ),
      officialLinks: null,
      originalLanguage: "ja",
      lastVolume: "105",
      lastChapter: "1050",
      publicationDemographic: "Shonen",
      status: "Ongoing",
      year: 1997,
      contentRating: "PG-13",
      tags: [],
      state: "Ongoing",
      chapterNumbersResetOnNewVolume: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
      availableTranslatedLanguages: ["en", "es", "fr", "de"],
      latestUploadedChapter: "1050",
    ),
    relationships: [
      Relationship(id: "2", type: "author", related: "Eiichiro Oda"),
    ],
  ),
];

class MangadexRepositoryFake implements MangadexRepository {
  @override
  Future<List<MangaData>> getMangaSeries() async {
    await Future.delayed(Duration(seconds: 2));
    print(fakeMangaList);
    return fakeMangaList;
  }

  @override
  Future<Map<String, Volume>> getMangaChapters(String mangaId) {
    // TODO: implement getMangaChapters
    throw UnimplementedError();
  }
}
